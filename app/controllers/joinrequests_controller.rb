class JoinrequestsController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
   def new
   @idea_posting = IdeaPosting.find(params[:idea_posting_id])
   @user = User.find(current_user.id)
   @joinrequest = @idea_posting.joinrequests.new({:userid => current_user.id}, {:idea_posting_id => @idea_posting.id})

   respond_to do |format|
        if current_user != nil && current_user.join_requests_mades.exists?(:idea_posting_id => @idea_posting.id) == false #if user is logged in and hasn't requested to join current project before
          format.html # new.html.erb
          format.json { render json: @joinrequest }
          format.js
        else
          @request_made = true
          format.json { render json: @idea_posting }
          format.js 
          format.html { redirect_to idea_posting_path(@idea_posting.id), notice: "You've already requested to join this project, or are not logged in."}
        end
    end
 
  end

  def create     
    unless current_user.joinrequests_remaining?
      return redirect_to root_path, notice: "You can't make any more requests today"
    end
    
    @idea_posting = IdeaPosting.find(params[:joinrequest][:idea_posting_id])
    
    #if the user is logged in and hasn't requested to join a given project before, proceed with creating joinrequest    
    if current_user != nil && current_user.join_requests_mades.where(:idea_posting_id => @idea_posting.id).exists? == false
      
      # Create a new joinrequest 
      @joinrequest = @idea_posting.joinrequests.new(params[:joinrequest])
      
      # Record that the user has requested to join this posting
      @user_has_made_request = current_user.join_requests_mades.new({:idea_posting_id => @idea_posting.id})
      
      respond_to do |format|
        if @joinrequest.save && @user_has_made_request.save #saves request in user and idea_posting models
          @request_made = true
          format.html { redirect_to root_path, notice: 'Request to join project sent' }
          format.json { render json: root_path, status: :created, location: @joinrequest }
          format.js
        else
          @joinrequest.destroy
          @user_has_made_request.destroy
          format.html { render action: "new" }
          format.json { render json: @joinrequest.errors, status: :unprocessable_entity }
          format.js
        end
      end   
    else
      redirect_to root_path, notice: "You've already requested to join this project, or are not logged in."
    end
  end

  def approve 

    joinrequest = Joinrequest.find(params[:id])
    idea_posting = joinrequest.idea_parent
    if idea_posting.users.exists?(current_user.id)
      new_project_user = User.find(joinrequest.userid)
      idea_posting.users << new_project_user
      new_project_user.idea_postings << idea_posting
      joinrequest.destroy
    end
    
    @all_requests = [] #[Joinrequest.new()]
    @users = []
    for owned_idea_posting in current_user.idea_postings.all #loops through user's idea postings
      for pending_request in owned_idea_posting.joinrequests.all #loops through requests in each idea posting
      @users << User.find(pending_request.userid) #adds user who is requesting to join to list of users
      @all_requests << pending_request #adds request to allrequests
      end
    end    
    
      respond_to do |format|
        format.html { redirect_to list_joinrequests_path }
        format.json { head :no_content }
        format.js {render 'index'}
      end
  end

  def reject 
    joinrequest = Joinrequest.find(params[:id])
    idea_posting = joinrequest.idea_parent
    if idea_posting.users.exists?(current_user.id)
      joinrequest.destroy
    end
    @all_requests = [] #[Joinrequest.new()]
    @users = []
    for owned_idea_posting in current_user.idea_postings.all #loops through user's idea postings
      for pending_request in owned_idea_posting.joinrequests.all #loops through requests in each idea posting
      @users << User.find(pending_request.userid) #adds user who is requesting to join to list of users
      @all_requests << pending_request #adds request to allrequests
      end
    end        
     respond_to do |format|
        format.html { redirect_to list_joinrequests_path }
        format.json { head :no_content }
        format.js {render 'index'}
     end
  end
  
  def index #show a list of all of the current user's requests, counts all requests to projects owned by user
    if current_user == nil
      return redirect_to root_path
    else
      @all_requests = [] #[Joinrequest.new()]
      @users = []
      for owned_idea_posting in current_user.idea_postings.all #loops through user's idea postings
        for pending_request in owned_idea_posting.joinrequests.all #loops through requests in each idea posting
          @users << User.find(pending_request.userid) #adds user who is requesting to join to list of users
          @all_requests << pending_request #adds request to allrequests
        end
      end
      if @all_requests.length == 0
        redirect_to root_path, notice: 'No pending requests'
      end
    end
  end
  
  
  #The stuff below isn't functional or linked to by anything, idk if we'll implement an invite feature
  
  def new_invite
    if idea_posting.users.exists?(current_user.id)
    @joinrequest = Joinrequest.new
      respond_to do |format|
        format.html 
        format.json {redirect_to @joinrequest}
      end
    end
  end
  
  def create_invite
    if idea_posting.users.exists?(current_user.id)
      @user_profile = Profile.find_by_name(params[:name]) #find profile of inputted user
      @user = User.find(@user_profile.user_id)
      idea_posting.users << @user
      @user.idea_postings << idea_posting
    end
  end
  
  
  
end


