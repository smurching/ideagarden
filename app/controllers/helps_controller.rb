class HelpsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  def helpful
    @feedback = Feedback.find(params[:feedback_id])
    @feedback.help += 1
    @feedback.save
  end

  def unhelpful
    @feedback = Feedback.find(params[:feedback_id])
    @feedback.help -= 1
    @feedback.save
  end

end
