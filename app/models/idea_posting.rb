class IdeaPosting < ActiveRecord::Base
  attr_accessible :name, :pitch, :description, :tags, :user_id

  has_and_belongs_to_many :users
  has_many :feedbacks

end