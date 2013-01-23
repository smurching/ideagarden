class Profile < ActiveRecord::Base
  validates :name, :presence => true
  validates :name, :bio, :user_id, :presence => true
  attr_accessible :bio, :name, :user_id, :photo
  

  belongs_to :user

  has_attached_file :photo, styles: { small: "130x130>", thumb: "45x45>" }
end