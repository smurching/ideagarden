class Feedback < ActiveRecord::Base

  validates :body, :length => {:within => 10..1000}
  
  attr_accessible :body, :idea_posting_id, :name, :user_id, :private, :feedback_id, :topic, :title, :root_id

  belongs_to :idea_posting
  belongs_to :user
  
  has_many :feedbacks
  has_many :feedback_votes
  
  def all_replies_helper
    output = [self]
    
    # If a feedback has no children, return the feedback itself
    if (children = self.feedbacks) == []
      return output
     
    # Otherwise, return the feedback and its children by
    # recursively calling all_replies_helper
    else
      children.each do |child|
        output << child.all_replies_helper
      end
    end
    
    return output.flatten
  end
  
  def all_replies
    output = self.all_replies_helper
    output.slice!(0)
    return output
  end
  
  def root_feedback
    if self.root_id
      Feedback.find(self.root_id)
    else
      return self
    end
  end
  
  def root
    if (root = self.root_feedback) == self
      return self.idea_posting
    else
      return root
    end
  end
  
end
