class Profile < ActiveRecord::Base
  validates :name, :uniqueness => true
  validates :name, :bio, :user_id, :presence => true
  attr_accessible :bio, :name, :user_id
  

  belongs_to :user

end