require 'bcrypt'
  

class User < ActiveRecord::Base
  include BCrypt
  
  before_save :is_user_teacher?
  
def is_user_teacher?
 nil_if_not_teacher = self.email["wednet.edu"]
 unless nil_if_not_teacher == nil
    self.teacher = true
 end   
end
  
  validates :email, :uniqueness => true
  validates :password_hash, :confirmation => true
  validates :email, :format => {:with => /\A[a-zA-Z0-9]+@[a-zA-Z]+[.][a-zA-Z.]+\z/, :message => 'is not valid. Please input a valid email address'}  

  
  
  attr_accessible :email, :email_confirmation, :password_hash_confirmation, :posting_votes
  #unaccessible attributes: reset_code, confirmation_code
  attr_accessor :accessible

  
  has_one :profile
  has_and_belongs_to_many :idea_postings, :uniq => true
  has_many :feedbacks
  has_many :responses, :through => :articles, :source => :feedbacks
  has_many :join_requests_mades
  has_many :followings #follows many people - this is worded weirdly but that's what it means
  has_many :followers
  has_many :private_messages
  serialize :posting_votes, Array
  
  
  #BCRYPT STUFF STARTS HERE
  
  def password # This is what is called whenever @user.password is referenced. Returns a Password object from the data in a stored encrypted hash
    if password_hash != nil
     @password ||= Password.new(password_hash)
    else
      return false
    end
  end

  def password_create(new_password) #params[:password] should be passed into this in a secure fashion
      @password = Password.create(new_password)
      self.password_hash = @password
  end



 def self.login(email, password)  #shouldn't be any params
    @user = User.find_by_email(email) # parameter here should be params[:email]
    if @user == nil || @user.password != password
      return false
    else
      return @user 
    end
 end
  
 def self.password_create(new_password)
  @password = Password.create(new_password)
  self.password_hash = @password
 end
 
 def mass_assignment_authorizer(role = :default)
    super + (accessible || [])
 end
 
 def postings_commented_on
   posting_list = []
   copy = []
   users_feedbacks = []
   self.feedbacks.each do |feedback|
     users_feedbacks << feedback
   end
   users_feedbacks.each do |feedback| # loop through the user's feedbacks
      if feedback.idea_posting_id != nil  #if a feedback is a direct comment on a posting, add the posting to the list of postings
        posting_list << IdeaPosting.find(feedback.idea_posting_id)        
      # if a feedback (denoted x) is a reply to another piece of feedback,
      # loop through all of x's parents until the result is a feedback
      # that is a direct comment on a posting         
 
            
      else           
        root_feedback_found = false
        current_feedback = feedback 
        while root_feedback_found == false
          parent = Feedback.find(current_feedback.feedback_id) # parent is the piece of feedback that the current feedback belongs to
          if parent.idea_posting_id != nil
            root_feedback_found = true
            posting_list << IdeaPosting.find(parent.idea_posting_id)
          end        
          users_feedbacks.delete(parent)
          copy.delete(parent)          
          current_feedback = parent
        end
      end
     end
 return posting_list   
 end
 
 def followers_list
   followers_list = []
   followers_objects = self.followers
   for object in followers_objects
     followers_list << User.find(object.user_id)
   end
   return followers_list
 end
 
  def followed_users_list
   followings_list = []
   followings_objects = self.followings
   for object in followings_objects
     followings_list << User.find(object.user_id)
   end
   return followings_list
 end
 
 

 def from_follower?(posting)
  users = posting.users
  followers = self.followers_list
  users.each do |user|
    if followers.include?(user)
      return true      
    end
  end
  return false
   
 end
 
 def from_followed_user?(posting)
   users = posting.users
   followed_users = self.followed_users_list
   users.each do |user|
     if followed_users.include?(user)
       return true
     end
   end
   return false   
 end
 
 
end
