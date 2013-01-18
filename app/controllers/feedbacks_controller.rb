class FeedbacksController < ApplicationController
  # GET /feedbacks
  # GET /feedbacks.json
  before_filter :login_filter, :except => [:index, :show] #the except cases shouldn't ever be necessary but I added them in case we decide to do something with feedbacks#index or feedbacks#show
  before_filter :registration_filter, :except => [:index, :show] 
   def index
    @feedbacks = Feedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feedback }
    end
  end

  # GET /feedbacks/1/edit
  def edit
    @feedback = Feedback.find(params[:id])
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create2
    @feedback = @idea_posting.feedbacks.new(params[:feedback])
    if params[:feedback][:topic] || params[:feedback][:topic] == false
      @idea_posting = IdeaPosting.find(params[:idea_posting_id]) # set idea posting variable, should be 'load_idea_posting' method
      respond_to do |format|
        if @feedback.save
          current_user.feedbacks << @feedback
          format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback was successfully created.' }
          format.json { render json: @feedback, status: :created, location: @feedback }
          format.js 
        else
          @failed_to_post = true
          format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback must be between 10 and 1000 characters' }
          format.json { render json: @feedback.errors, status: :unprocessable_entity }
          format.js 
        end
      end
    end     
  end
  
  def create
    @idea_posting = IdeaPosting.find(params[:idea_posting_id]) # set idea posting variable, should be 'load_idea_posting' method
    @feedback = @idea_posting.feedbacks.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        current_user.feedbacks << @feedback #Sets user_id of feedback to the ID of the current user
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
        format.js 
      else
        @failed_to_post = true
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback must be between 10 and 1000 characters' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
        format.js 
      end
    end    
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attributes(params[:feedback])
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def new_reply
    @idea_posting = IdeaPosting.find(params[:id]) #posting is passed in as an instance variable so that its ID can be passed to the create action
    @feedback = Feedback.find(params[:feedback_id]) #parent feedback
    respond_to do |format|
      format.html {render '_form'}
      format.js 
    end
  end
  def cancel_reply #there has to be a better way of doing this - cancel buttons should be available to all controllers
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = Feedback.find(params[:feedback_id])
    respond_to do |format|
      format.html {redirect_to idea_posting_path}
      format.js
    end
  end
  def create_reply
    @idea_posting = IdeaPosting.find(params[:id])
    @feedback = Feedback.find(params[:feedback_id])
    if @feedback.private == nil || @idea_posting.users.include?(current_user)
    @child = @feedback.feedbacks.new(params[:feedback])
    respond_to do |format|
      if @child.save
        current_user.feedbacks << @child #Sets user_id of feedback to the ID of the current user
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Reply saved'}
        format.js
      else
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Something prevented your reply from being saved'}
      end            
    end
   else
     redirect_to idea_posting_path(@idea_posting.id), notice: "You don't have permission to do that"
   end
 end
  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end
  
end
