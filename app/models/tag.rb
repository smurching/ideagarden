class Tag < ActiveRecord::Base
   attr_accessible :idea_posting_id, :value
   belongs_to :idea_posting
end
