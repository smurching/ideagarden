class HelpsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  def helpful
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = @idea_posting.feedbacks.find(params[:feedback_id])
    @feedback.help += 1
    @feedback.save
  end

  def unhelpful
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = @idea_posting.feedbacks.find(params[:feedback_id])
    @feedback.help -= 1
    @feedback.save
  end

end
