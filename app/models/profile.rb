class Profile < ActiveRecord::Base
  attr_accessible :bio, :name, :user_id

  belongs_to :user

end