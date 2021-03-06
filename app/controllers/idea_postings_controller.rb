
class IdeaPostingsController < ApplicationController
  # GET /idea_postings
  # GET /idea_postings.json

  before_filter :login_filter, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :registration_filter, :only => [:new, :edit, :create, :update, :destroy]
  
  def index
    if params[:id] != nil
      @idea_posting = IdeaPosting.find(params[:id])    
    elsif logged_in?
      @idea_postings = IdeaPosting.desc.all
    else
      @idea_postings = IdeaPosting.featured_posts
    end
    
    if logged_in?
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @idea_postings }
        format.js          
      end
    else
      @user = User.new
      @profile = Profile.new      
      respond_to do |format|
        format.html  {render :layout => "plain_layout", :template => "sessions/_form"}
        format.js
      end
    end
  end
  
  def public_topics
    @idea_posting = IdeaPosting.find(params[:id])
    respond_to do |format|
      format.html {render :partial => "topics_list", :locals => {:feedbacks => @idea_posting.public_feedbacks}}
    end
  end
  
  def private_topics
    @idea_posting = IdeaPosting.find(params[:id])
    respond_to do |format|
      format.html {render :partial => "topics_list", :locals => {:feedbacks => @idea_posting.private_feedbacks}}
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
  
  def search_by_name
    @idea_postings = IdeaPosting.find_by_name(params["title"])
    if !@idea_postings
      @idea_postings=[]
    end
    
    respond_to do |format|
      format.html {render "search"}
    end
  end  
  
  
  def search
    @idea_postings = IdeaPosting.search(params, current_user)
    
    respond_to do |format|
      format.html # index.html.erb
      format.js # {render 'search' }
    end
  end

  def channel
    #renders channel.html  
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
      @tags = IdeaPosting.tags
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
    @tags = IdeaPosting.tags
    @idea_posting = IdeaPosting.find(params[:id])
    if current_user == nil || @idea_posting.users.exists?(current_user.id) == false
      redirect_to root_path
    end
  end

  # POST /idea_postings
  # POST /idea_postings.json
  def create
    @tags = IdeaPosting.tags
    @idea_posting = IdeaPosting.new(params[:idea_posting])

     
    
    if params[:facebook] == "true"
      @post_to_facebook = true
    else
      @post_to_facebook = false
    end
    
    if params[:under_execution] == "true"
      @idea_posting.state = true
    end
    # for tag in @tags
    #  @idea_posting.tags.new({:value => tag.name})
    # end
    

      respond_to do |format|
        if @idea_posting.save
          
          tags_list = TagsList.new(:idea_posting_id => @idea_posting.id)
          tags_list.set_attributes(params)    
          tags_list.save      
          
          @posting_saved = true          
          current_user.idea_postings << @idea_posting #idea_posting added to current user
          @idea_posting.users << User.find(current_user.id) #current user added to idea_posting's list of owners
          
          format.html { render "show", notice: 'Idea posting was successfully created.' }
          format.json { render json: @idea_posting, status: :created, location: @idea_posting }
          format.js        
          
        else
          @posting_saved = false
          format.html { render "new" }
          format.json { render json: @idea_posting.errors, status: :unprocessable_entity }
          format.js
        end
      end

  end

  # PUT /idea_postings/1
  # PUT /idea_postings/1.json
  def update 
    @idea_posting = IdeaPosting.find(params[:id])
    @tags = IdeaPosting.tags
    tag_hash = IdeaPosting.search_hash
    

    
      if @idea_posting.users.exists?(current_user.id) #does user own the idea posting? if yes, update the posting
        
        tags_list = @idea_posting.tags_list
        tags_list.set_attributes(params)    
        tags_list.save  
    
        if params[:facebook] == "true"
          @post_to_facebook = true
        else
          @post_to_facebook = false
        end
    
        if params[:under_execution] == "true"
          @idea_posting.state = true
        end
         
        
        
        respond_to do |format|
          if @idea_posting.update_attributes(params[:idea_posting])
            @posting_saved = true
            format.html { redirect_to @idea_posting, notice: 'Idea posting was successfully updated.' }
            format.json { head :no_content }
            format.js {render "create"}
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





