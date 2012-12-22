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
  def create
    @idea_posting = IdeaPosting.find(params[:idea_posting_id]) # set idea posting variable, should be 'load_idea_posting' method
    @feedback = @idea_posting.feedbacks.new(params[:feedback])

    respond_to do |format|
      if @feedback.save
        current_user.feedbacks << @feedback
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback was successfully created.' }
        format.json { render json: @feedback, status: :created, location: @feedback }
        format.js 
      else
        @failed_to_post = true
        format.html { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback must be at least 10 characters long' }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
        format.js { redirect_to idea_posting_path(@idea_posting.id), notice: 'Feedback must be at least 10 characters long'} #redirect_to idea_posting_path(@idea_posting.id) or render 'idea_postings/show'
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
