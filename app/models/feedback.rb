class Feedback < ActiveRecord::Base
  attr_accessible :body, :idea_posting_id, :name, :user_id

  belongs_to :idea_posting
  belongs_to :user

end
