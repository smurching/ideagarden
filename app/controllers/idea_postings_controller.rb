class IdeaPostingsController < ApplicationController
  # GET /idea_postings
  # GET /idea_postings.json
  def index
    @idea_postings = IdeaPosting.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @idea_postings }
    end
  end

  # GET /idea_postings/1
  # GET /idea_postings/1.json
  def show
    @idea_posting = IdeaPosting.find(params[:id])

    @check = true

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea_posting }
    end
  end

  # GET /idea_postings/new
  # GET /idea_postings/new.json
  def new
    @idea_posting = IdeaPosting.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea_posting }
    end
  end

  # GET /idea_postings/1/edit
  def edit
    @idea_posting = IdeaPosting.find(params[:id])
  end

  # POST /idea_postings
  # POST /idea_postings.json
  def create
    @idea_posting = IdeaPosting.new(params[:idea_posting])

    respond_to do |format|
      if @idea_posting.save
        format.html { redirect_to @idea_posting, notice: 'Idea posting was successfully created.' }
        format.json { render json: @idea_posting, status: :created, location: @idea_posting }
      else
        format.html { render action: "new" }
        format.json { render json: @idea_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /idea_postings/1
  # PUT /idea_postings/1.json
  def update
    @idea_posting = IdeaPosting.find(params[:id])

    respond_to do |format|
      if @idea_posting.update_attributes(params[:idea_posting])
        format.html { redirect_to @idea_posting, notice: 'Idea posting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @idea_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /idea_postings/1
  # DELETE /idea_postings/1.json
  def destroy
    @idea_posting = IdeaPosting.find(params[:id])
    @idea_posting.destroy

    respond_to do |format|
      format.html { redirect_to idea_postings_url }
      format.json { head :no_content }
    end
  end
end
