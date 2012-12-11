class Feedback < ActiveRecord::Base
  validates :body, :length => {:within => 10..1000}
  attr_accessible :body, :idea_posting_id, :name, :user_id, :help, :private

  belongs_to :idea_posting
  belongs_to :user

  
  
end
