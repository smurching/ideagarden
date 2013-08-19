class IdeaPostingsController < ApplicationController
  # GET /idea_postings
  # GET /idea_postings.json

  before_filter :login_filter, :except => [:index, :show, :search, :filter_by_followers]
  before_filter :registration_filter, :except => [:index, :show, :search, :filter_by_followers]
  
  
  
  def index
    @idea_postings = IdeaPosting.desc.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @idea_postings }
      format.js
    end
  end
  
  def filter_by_followers
    @filtering = true
    case
    when params["followed users' posts"] != nil && current_user != nil
      @idea_postings = []
      followed_users = []
      for relationship_object in current_user.followings.all
        followed_users << User.find(relationship_object.followed_user_id) # add all followed users to list
      end
           
      for user in followed_users
        for idea_posting in user.idea_postings.all
          unless @idea_postings.include? idea_posting
            @idea_postings << idea_posting
          end
        end
      end      
      
    when params["followers' posts"] != nil && current_user != nil
      followers = []
      @idea_postings = []
      for relationship_object in current_user.followers.all
        followers << User.find(relationship_object.follower_user_id) # add all followed users to list
      end
      
      for user in followers
        for idea_posting in user.idea_postings.all
          unless @idea_postings.include? idea_posting
            @idea_postings << idea_posting
          end
        end
      end
    else
      @idea_postings = IdeaPosting.all
    end

    respond_to do |format|
      format.html {render 'index'}
      format.json { render json: @idea_postings }
      format.js {render 'index'}
    end      
      
  end
  
  def search
  	@idea_postings = IdeaPosting.find_by_name(params["title"])
  	if !@idea_postings
  		@idea_postings=[]
  	end
  end
    




  # GET /idea_postings/1
  # GET /idea_postings/1.json
  def show
    @idea_posting = IdeaPosting.find(params[:id])
    @user = current_user
    @check = true
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @idea_posting }
    end
  end

  # GET /idea_postings/new
  # GET /idea_postings/new.json
  def new
    if current_user != nil
      @idea_posting = current_user.idea_postings.new
      # @idea_posting.tags.new({:value => "cake"})
      @tags = ["technology", "science & math", "language", "art", "community service", "research", "making things"]
      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @idea_posting }
    end
    else
      return redirect_to root_path
    end
  end

  # GET /idea_postings/1/edit
  def edit
    @tags = ["technology", "science & math", "language", "art", "community service", "research", "making things"]
    @idea_posting = IdeaPosting.find(params[:id])
    if current_user == nil || @idea_posting.users.exists?(current_user.id) == false
      redirect_to root_path
    end
  end

  # POST /idea_postings
  # POST /idea_postings.json
  def create
    @tags = ["technology", "science & math", "language", "art", "community service", "research", "making things"]
    @idea_posting = IdeaPosting.new(params[:idea_posting])
    create_tags
    # for tag in @tags
    #  @idea_posting.tags.new({:value => tag.name})
    # end
    respond_to do |format|
      if @idea_posting.save
        current_user.idea_postings << @idea_posting #idea_posting added to current user
        @idea_posting.users << User.find(current_user.id) #current user added to idea_posting's list of owners
        format.html { redirect_to @idea_posting, notice: 'Idea posting was successfully created.' }
        format.json { render json: @idea_posting, status: :created, location: @idea_posting }
      else
        format.html { render "new" }
        format.json { render json: @idea_posting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /idea_postings/1
  # PUT /idea_postings/1.json
  def update
    @tags = ["technology", "science & math", "language", "art", "community service", "research", "making things"]    
    @idea_posting = IdeaPosting.find(params[:id])
      if @idea_posting.users.exists?(current_user.id) #does user own the idea posting? if yes, update the posting
        @idea_posting.tags.each do |tag|
          tag.destroy
        end
        create_tags
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
  end

  # DELETE /idea_postings/1
  # DELETE /idea_postings/1.json
  def destroy
    @idea_posting = IdeaPosting.find(params[:id])
    if @idea_posting.users.exists?(current_user.id)
         @idea_posting.destroy
    end
    respond_to do |format|
      format.html { redirect_to idea_postings_url }
      format.json { head :no_content }
    end
  end
end
