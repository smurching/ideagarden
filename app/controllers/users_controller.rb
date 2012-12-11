class UsersController < ApplicationController

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  def create #email to confirm user is sent after profile is created - it is therefore in the profiles#create
    if params[:user][:password_hash].length < 6
      return redirect_to new_user_path, notice: 'Password must be at least six characters long'
    end
    @user = User.new(params[:user]) #password_hash won't be assigned if it's protected from mass-assignment - it currently is not.
    @user.password_hash = @user.password_create(@user.password_hash)

    respond_to do |format|
      if @user.save
        format.html { redirect_to new_user_profile_path(@user.id), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # POST /users
  # POST /users.json


  def confirm
    user = User.find_by_confirmation_code(params[:confirmation_code])
    user.confirmed = true
    redirect_to root_path, notice: 'Your registration has been confirmed!'
  end
  
  def new_password_reset_request #loads page in which user inputs his email to send reset request
  end
  
  def send_password_reset_request #sends reset request to user's email
    site_url = "http://localhost:3000"
    @user = User.find_by_email(params[:email])
    if @user == nil
      return redirect_to new_pw_reset_path, notice: 'Please try again - no users are registered with the email you provided.'
    end
    @user.reset_code = Array.new(20).map{rand(10).chr}.join
    @user.idea_postings << IdeaPosting.new()
    ideaposting = @user.idea_postings[0]
    reset_request = ideaposting.joinrequests.new({:message => site_url + "/passwords/" + @user.reset_code})
    reset_request.save
    @user.save
    
    # UserMailer.reset_password(@user).send ADD THIS WHEN YOU'RE LEGITLY SENDING EMAILS
    
    # user.reset_code_timestamp = DateTime.now
    return redirect_to root_path, notice: 'Reset request sent'
  end
  
  def show_pw_reset_requests
    @all_requests = current_user.idea_postings[0].joinrequests.all
   render 'joinrequests/pwreset'
  end
  def load_password_reset_page #loads the page in which the user picks a new password and confirms it
  end
  
  def reset_password #resets user's password
    @user = User.find_by_reset_code(params[:reset_code])
    sleep(1.seconds) #what would be cool is if this got larger with successive wrong attempts
    if params[:password_hash].length < 6 
      return redirect_to load_pw_reset_path, notice: 'New password must be at least six characters long'
    end
    
    if @user == nil
      return redirect_to root_path, notice: 'Invalid page'
    end
    @user.password_hash = @user.password_create(params[:password_hash])
    @user.save
    return redirect_to root_path, notice: 'Password reset successfully'
    
  end
  # PUT /users/1
  # PUT /users/1.json

  def follow
    user_being_followed = User.find(params[:id])
    @user = user_being_followed
    if user_being_followed.followers.exists?(:follower_user_id => current_user.id) == false
      
      add_relationship_to_follower = current_user.followings.new(:followed_user_id => user_being_followed.id)
      add_relationship_to_user_being_followed = user_being_followed.followers.new(:follower_user_id => current_user.id)
      respond_to do |format|
        if add_relationship_to_follower.save && add_relationship_to_user_being_followed.save
          format.html { redirect_to user_profiles_path(user_being_followed.id), notice: 'Now following '+user_being_followed.profile.name }
          format.json { render json: @user, status: :created, location: @user }
       else
        format.html { redirect_to user_profiles_path(user_being_followed.id), notice: 'Unable to follow'+user_being_followed.profile.name }
        format.json { render json: @user.errors, status: :unprocessable_entity }
       end
      end
    else
      redirect_to user_profiles_path(user_being_followed.id), notice: 'Already following '+user_being_followed.profile.name
    end 
  end
  
  def unfollow
    user_being_unfollowed = User.find(params[:id])
    relationship_for_current_user = current_user.followings.find_by_followed_user_id(user_being_unfollowed.id)
    relationship_for_user_being_unfollowed = user_being_unfollowed.followers.find_by_follower_user_id(current_user.id)
    relationship_for_user_being_unfollowed.destroy
    relationship_for_current_user.destroy
    if relationship_for_user_being_unfollowed.destroy &&  relationship_for_current_user.destroy
      redirect_to user_profiles_path(user_being_unfollowed.id), notice: 'User unfollowed'
    else
      redirect_to user_profiles_path(user_being_unfollowed.id), notice: 'Unable to unfollow '+user_being_unfollowed.profile.name
    end
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
