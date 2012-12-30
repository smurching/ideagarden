class PotentialsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  def upvote
    @idea_posting = IdeaPosting.find(params[:id])
    @idea_posting.potential += 1
    @idea_posting.save
  end

  def downvote
    @idea_posting = IdeaPosting.find(params[:id])
    @idea_posting.potential -= 1
    @idea_posting.save
  end
  
end

