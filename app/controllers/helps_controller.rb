class HelpsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  def helpful
        puts("---------------------------------in helpful----------------------------")    
    @feedback = Feedback.find(params[:feedback_id])
    # If the user tried voting on a feedback that doesn't exist, do nothing
    unless @feedback == nil
      
      # If the user already upvoted this feedback, do nothing
      if (previous_upvote = current_user.feedback_votes.where("feedback_id = ? AND is_upvote = TRUE", @feedback.id)) != []
        puts("---------------------------------first----------------------------")
        return
        
      # If the user downvoted this feedback, delete the downvote and save a new upvote
      elsif (previous_downvote = current_user.feedback_votes.where("feedback_id = ? AND is_upvote = FALSE", @feedback.id))!= []
        puts("---------------------------------second----------------------------")        
        previous_downvote[0].destroy
        new_upvote = current_user.feedback_votes.create({:feedback_id => @feedback.id, :is_upvote => true})
        @feedback.help += 2
        
      # If the user hasn't upvoted or downvoted this feedback, create a new upvote
      else
        puts("---------------------------------third----------------------------")        
        new_upvote = current_user.feedback_votes.create({:feedback_id => @feedback.id, :is_upvote => true})
        @feedback.help += 1
      end
    
      @feedback.save
    end
          
  end

  def unhelpful
    @feedback = Feedback.find(params[:feedback_id])
    
    unless @feedback == nil
      
      # Already downvoted --> do nothing
      if (previous_downvote = current_user.feedback_votes.where("feedback_id = ? AND is_upvote = FALSE", @feedback.id)) != []
        return
      
      # Upvoted --> delete the upvote, create a downvote
      elsif (previous_upvote = current_user.feedback_votes.where("feedback_id = ? AND is_upvote = TRUE", @feedback.id)) != []
        previous_upvote[0].destroy
        new_downvote = current_user.feedback_votes.create({:feedback_id => @feedback.id, :is_upvote => false})
        @feedback.help -= 2
        
      # No upvote or downvote --> create a downvote        
      else
        new_downvote = current_user.feedback_votes.create({:feedback_id => @feedback.id, :is_upvote => false})
        @feedback.help -=1
      end
    
      @feedback.save
    end
          
  end

end
