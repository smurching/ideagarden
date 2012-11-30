class JoinRequestsMade < ActiveRecord::Base
  attr_accessible :idea_posting_id, :user_id
  belongs_to :user
  
  
  def idea_parent
    return IdeaPosting.find(:idea_posting_id)
  end
  
  def user_parent
    return User.find(:user_id)
  end
end

