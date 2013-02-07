
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
  attr_accessible :email, :password_hash, :email_confirmation, :password_hash_confirmation, :posting_votes
  #unaccessible attributes: reset_code, confirmation_code
  

  
  has_one :profile
  has_and_belongs_to_many :idea_postings, :uniq => true
  has_many :feedbacks
  has_many :responses, :through => :articles, :source => :feedbacks
  has_many :join_requests_mades
  has_many :followings #follows many people - this is worded weirdly but that's what it means
  has_many :followers
  serialize :posting_votes, Array
  
  
  #BCRYPT STUFF STARTS HERE
  
  def password # This is what is called whenever @user.password is referenced. Returns a Password object from the data in a stored encrypted hash
     @password ||= Password.new(password_hash)
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
 
end
