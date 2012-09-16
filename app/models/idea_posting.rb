class IdeaPosting < ActiveRecord::Base
  attr_accessible :name, :pitch, :description, :tags
end
