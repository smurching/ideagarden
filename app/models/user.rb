class User < ActiveRecord::Base
  attr_accessible :email, :password

  has_one :profile
  has_and_belongs_to_many :idea_postings
  has_many :feedbacks
  has_many :responses, :through => :articles, :source => :feedbacks

  def authenticated?(password)
    self.password == password
  end

  def self.authenticate(email, password)
    user = find_by_email(email)
    return user if user && user.authenticated?(password)
  end

end
