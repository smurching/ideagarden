class FeedbackVote < ActiveRecord::Base
  attr_accessible :feedback_id, :user_id, :is_upvote
  
  belongs_to :user
  belongs_to :feedback
end
