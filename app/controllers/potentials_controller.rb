class PotentialsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  def upvote
    @idea_posting = IdeaPosting.find(params[:id])
    if @idea_posting.potential == nil
      @idea_posting.update_attributes(potential: 0)
    end
    @n = @idea_posting.potential
    @idea_posting.update_attributes(potential: @n + 1)
  end

  def downvote
    @idea_posting = IdeaPosting.find(params[:id])
    if @idea_posting.potential == nil
      @idea_posting.update_attributes(potential: 0)
    end
    @n = @idea_posting.potential
    @idea_posting.update_attributes(potential: @n - 1)
  end
  
end

