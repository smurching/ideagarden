class RecentVotes < ActiveRecord::Base
  attr_accessible :idea_posting_id, :is_upvote
  # Attributes: idea_posting_id, is_upvote
end
