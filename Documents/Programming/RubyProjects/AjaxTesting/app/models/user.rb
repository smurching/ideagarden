require 'bcrypt'
  

class User < ActiveRecord::Base
  include BCrypt
  
  validates :email, :uniqueness => true
  #validates :email, :confirmation => true
  validates :password_hash, :confirmation => true
  validates :email, :format => {:with => /\A[a-zA-Z0-9]+@[a-zA-Z]+[.][a-zA-Z]+\z/, :message => 'is not valid. Please input a valid email address'}
  
  attr_accessible :email, :password_hash, :email_confirmation, :password_hash_confirmation
  has_one :profile
  has_and_belongs_to_many :idea_postings, :uniq => true
  has_many :feedbacks
  has_many :responses, :through => :articles, :source => :feedbacks
  has_many :join_requests_mades
  
# ALL OF THIS STUFF WORKS WITHOUT BCRYPT 

  #def self.authenticated(email, password)
  #  user = find_by_email(email)
   # if user.password == password
    #  return user
   # else
    #  return false
    #end
  #end

  #def self.authenticate(email, password)
   # user = find_by_email(email)
    #return user if user && user.authenticated?(password)
  #end
  
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
  
def forgot_password(email) #shouldn't be any params
    @user = User.find_by_email(email) #parameter here should be params[:email]
    random_password = Array.new(10).map { (65 + rand(58)).chr }.join
    @user.password_hash = random_password
    @user.save!
    Mailer.create_and_deliver_password_change(@user, random_password)
  end


end