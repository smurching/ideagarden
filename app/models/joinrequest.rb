class Joinrequest < ActiveRecord::Base
  
  validates :message, :length => {:within => 10..1000}
  attr_accessible :idea_posting_id, :message, :userid
  belongs_to :idea_posting
  belongs_to :user
 
  def user_parent
    return User.find(userid)
  end
  
  def idea_parent
    return IdeaPosting.find(idea_posting_id)
  end
end
