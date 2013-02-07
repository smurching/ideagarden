module FeedbacksHelper

  def from_followed_user?(feedback) 
    feedback_creator = User.find(feedback.user_id)
    if logged_in?
      if current_user.followings.find_by_followed_user_id(feedback_creator.id) != nil #if current_user is following the user who has created the feedback
        return true 
      end
    else
      return false  
    end 
  end

end
