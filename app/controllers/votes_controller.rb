class VotesController < ApplicationController

  before_filter :login_filter
  before_filter :registration_filter

  def posting_vote
    idea_posting_id = params[:id]
    unless current_user.posting_votes.include?(idea_posting_id.to_i)   
      @idea_posting = IdeaPosting.find(idea_posting_id)   
      @idea_posting.upvote
      current_user.posting_votes << idea_posting_id.to_i
      current_user.save
      @upvoted = true
      
      new_vote = RecentVotes.new({:is_upvote => true, :idea_posting_id => idea_posting_id})
      new_vote.save
      
      
      respond_to do |format|
        format.html {redirect_to root_path, notice: "You upvoted '#{idea_posting.name}'"}
        format.js {render 'idea_postings/index'}  
      end
    else
      redirect_to root_path   
    end
  end

  def posting_unvote
    idea_posting_id = params[:id]
    if current_user.posting_votes.include?(idea_posting_id.to_i)       
      @idea_posting = IdeaPosting.find(idea_posting_id)
      @idea_posting.unvote
      current_user.posting_votes.delete(idea_posting_id.to_i)
      current_user.save
      @unvoted = true    
      
      # new_vote = RecentVotes.new({:is_upvote => false, :idea_posting_id => idea_posting_id})
      # new_vote.save
      
      respond_to do |format|
        format.html {redirect_to root_path, notice: "You unvoted '#{idea_posting.name}'"}
        format.js {render'idea_postings/index'}
      end
    else
      redirect_to root_path
    end
  end

  def check_vote
    idea_posting_id = params[:id].to_i
    counter = 0
    votes = current_user.posting_votes
    votes.each do |f|
      if f === idea_posting_id
        counter += 1
      end
      if counter > 1
        access_denied
      end
    end
  end

end