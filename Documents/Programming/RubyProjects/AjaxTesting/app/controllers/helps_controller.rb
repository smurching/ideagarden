class HelpsController < ApplicationController

  def helpful
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = @idea_posting.feedbacks.find(params[:feedback_id])
    if @feedback.help == nil
      @feedback.update_attributes(help: 0)
    end
    @n = @feedback.help
    @feedback.update_attributes(help: @n + 1)
  end

  def unhelpful
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = @idea_posting.feedbacks.find(params[:feedback_id])
    if @feedback.help == nil
      @feedback.update_attributes(help: 0)
    end
    @n = @feedback.help
    @feedback.update_attributes(help: @n - 1)
  end

end
