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
  has_many :feedback_votes
  
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
   #followers_list = []
   #followers_objects = self.followers
   #for object in followers_objects
   #  followers_list << User.find(object.follower_user_id)
   #end
   #return followers_list
   
   # Joins users and followers tables ON user.id = followers.user_id
   # (wherever a user's id matches a follower object's user_id attribute).
   # Then, selects from results where user.id is equal to the
   # user instance's id
   
   User.joins(:followers).where("users.id = ?", self.id)
 end
 
  def followed_users_list
   #followings_list = []
   #followings_objects = self.followings
   #for object in followings_objects
   #  followings_list << User.find(object.user_id)
   #end
   #return followings_list
   
   # Joins users and followers tables ON user.id = followings.user_id
   # (wherever a user's id matches a following object's user_id attribute).
   # Then, selects from results where user.id is equal to the
   # user instance's id
      
   User.joins(:followings).where("users.id = ?", self.id)
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

 def feedbacks_remaining(topics = false, limit = 20)
   time_threshold = 3600*24
   recent_feedbacks = Feedback.joins("INNER JOIN users ON users.id = feedbacks.user_id AND users.id = #{self.id} AND feedbacks.topic = #{topics.to_s}").order("created_at DESC")
      
   # limit = how many postings back we check 
   # (e.g. a limit of 5 means we check the 5th oldest posting
   # to make sure it's not younger than a day
      
   (1..limit).each do |i|
     index = limit-i
     
     # if there is an <-limit+i>th oldest feedback, check to see if it's younger than
     # <time_threshold> seconds (currently one day)
     
     # since we're starting at the <-limit>th oldest feedback and working our way
     # up to the youngest feedback, once we find a feedback younger than a day,
     # all the remaining feedbacks will also be younger than a day and we can stop
     
     if recent_feedbacks[index] != nil
       time_since_creation = Time.now-recent_feedbacks[index].created_at
       if time_since_creation < time_threshold 
         return i-1
       end
                 
     # if we've reached the youngest feedback posted by the user and said feedback
     # is still older than 1 day, the user's feedback quota is unused  
     elsif index == 0
       return limit
     else
       # if the user doesn't have <limit> feedbacks, we may end up here
       # in that case, do nothing
     end
     
   end
    
 end
 
 def topics_remaining(limit = 5)
   feedbacks_remaining(true, limit)
 end
 
 def topics_remaining?
   if self.topics_remaining == 0
     return false
   else
     return true
   end
 end
 
 def feedbacks_remaining?
   if self.feedbacks_remaining == 0
     return false
   else
     return true
   end
 end
 
 
 
end
