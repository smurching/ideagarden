class UsersController < ApplicationController

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def new
    # used by profiles/_form.html.erb to tell whether
    # the form is for creating a new profile or updating the
    # profile of an existing user 
    @from_profiles_new = true
    @user = User.new
    @profile = Profile.new
    respond_to do |format|
      format.html {render :layout => "plain_layout"} # new.html.erb
      format.js
    end
  end

  def create_through_facebook
    
  end


  def create #email to confirm user is sent after profile is created - it is therefore in the profiles#create
    @from_profiles_new = true  
    @user  = User.new
    @profile = Profile.new(params[:profile])    
  
  
    # if user signed up through html registration form
    if params[:user] != nil
      if params[:user][:password_hash].length < 6
        return redirect_to new_user_path, notice: 'Password must be at least six characters long'
      end

      #password_hash won't be assigned if it's protected from mass-assignment - it currently is not.
      @user.accessible = [:password_hash]
      @user.attributes = params[:user]      
      @user.password_hash = @user.password_create(@user.password_hash)
      @user.confirmation_code = Array.new(20).map{rand(10)}.join
      

   #if user signed up through facebook   
   elsif params[:facebook] == "true"
     @user.email = params[:email]    
     @user.facebook = true
     @user.confirmed = true
     @profile.name =  params[:firstname]+" "+params[:lastname]    
     
     if User.find_by_email(@user.email) == nil 
       @user.save(:validate => false)
       @profile.user_id = @user.id     
       @profile.save
     
       respond_to do |format|
         format.html {return redirect_to root_path, notice: "Registration complete! You can log in through Facebook below"}
       end
     else
       respond_to do |format|
         format.html {return redirect_to root_path, notice: "An account with this email already exists"}
       end
     end
     
     
   #if user signed up through javascript popup (e.g. when user tries to vote without logging in)
   else
     @user.accessible = [:password_hash]
     @user.email = params[:email]
     @user.confirmation_code = Array.new(20).map{rand(10)}.join     
     @user.password_hash = @user.password_create(params[:password_hash])
   end

        
    @user.save(:validate => false)
    @profile.user_id = @user.id
    

    
    
    
    respond_to do |format|
      if @user.save && @profile.save
        
        ### Setting up the success dialog
        if @user.facebook == false
          case
          when @user.email["gmail.com"] != nil
            @email_url = "http://www.gmail.com"
          when @user.email["yahoo.com"] != nil
            @email_url = "http://www.mail.yahoo.com"
          when @user.email["hotmail.com"] != nil
            @email_url = "http://www.hotmail.com"
          when @user.email["live.com"] != nil
            @email_url = "http://www.live.com"
          when @user.email["http://comcast.net"] != nil
            @email_url = "https://www.login.comcast.net/login"
          end
          
          @registration_string = @email_url != nil ? "Please confirm your registration at "+@email_url : "Please check your email for a confirmation link."
                        
          UserMailer.welcome_email(@user).deliver

       
        else
          @registration_string = ""
          @user.confirmed = true                    
        end
        
        ### Success dialog has been set up

        @user_created = true        
        format.html { redirect_to root_path, notice: 'Profile was successfully created. '+@registration_string }          
        format.js {render 'profiles/new'}
      else
        @user.destroy
        @user_created = false
        format.html { redirect_to new_user_path}
        format.js {render 'profiles/new'}
      end
    end
  end

  

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



  #
  # 
  # USER CONFIRMATION ACTIONS
  #
  #

  def confirm
    user = User.find_by_confirmation_code(params[:confirmation_code])
    if user != nil
      user.confirmed = true
      user.save
      if user.teacher == true
        redirect_to root_path, notice: "Your registration has been confirmed! You've also been validated as a teacher, so you should be able to access private feedback and files posted under individual projects."
      else
        redirect_to root_path, notice: 'Your registration has been confirmed!'        
      end

    else
      redirect_to root_path, notice: 'Invalid confirmation code'
    end
  end
  
  def resend_confirmation
        case
        when current_user.email["gmail.com"] != nil
          email_url = "http://www.gmail.com"
          
        when current_user.email["yahoo.com"] != nil
          email_url = "http://www.mail.yahoo.com"
          
        when current_user.email["hotmail.com"] != nil
          email_url = "http://www.hotmail.com"
          
        when current_user.email["live.com"] != nil
          email_url = "http://www.live.com"
          
        when current_user.email["http://comcast.net"] != nil
          email_url = "https://www.login.comcast.net/login"
          
        end 
    if current_user.confirmed != true
      UserMailer.welcome_email(current_user).deliver
    end
    redirect_to root_path, notice: 'Confirmation email resent'
  end
  #
  # 
  # RESET PASSWORD ACTIONS
  #
  #
  
  def new_password_reset_request #loads page in which user inputs his email to send reset request
    respond_to do |format|
      format.html {render :layout => "blank_layout"}
    end
  end
  
  def send_password_reset_request #sends reset request to user's email
    @user = User.find_by_email(params[:email])
    if @user == nil
      return redirect_to new_pw_reset_path, notice: 'Please try again - no users are registered with the email you provided.'
    end
    @user.reset_code = Array.new(20).map{rand(10)}.join
    
    # USE THIS FOR TEST PURPOSES ONLY
    # @user.idea_postings << IdeaPosting.new()
    # ideaposting = @user.idea_postings[0]
    # reset_request = ideaposting.joinrequests.new({:message => site_url + "/passwords/" + @user.reset_code})
    # reset_request.save
    
    @user.save
    UserMailer.reset_password(@user).deliver # ADD THIS WHEN YOU'RE LEGITLY SENDING EMAILS
    
    # user.reset_code_timestamp = DateTime.now
    return redirect_to root_path, notice: 'Reset request sent'
  end
  
  def show_pw_reset_requests
   render 'joinrequests/pwreset'
  end

  def load_password_reset_page #loads the page in which the user picks a new password and confirms it
     @reset_code = params[:reset_code]
     @user = User.find_by_reset_code(@reset_code)
     if @user == nil
       return redirect_to root_path, notice: 'The page you requested does not exist'
     end
    respond_to do |format|
      format.html {render :layout => "blank_layout"}
    end     

  end
  
  def reset_password #resets user's password
    sleep(0.5.seconds) #what would be cool is if this got larger with successive wrong attempts         
    @user = User.find_by_reset_code(params[:reset_code])
    @user.reset_code = nil
    if params[:user][:password_hash].length < 6 
      return redirect_to load_pw_reset_path, notice: 'New password must be at least six characters long'
    end
    @user.password_hash = @user.password_create(params[:user][:password_hash])
    @user.save
    return redirect_to root_path, notice: 'Password reset successfully'
    
  end
  
  def existing_user
    @user = User.find_by_email(params[:email])
    if @user == nil
      @return_value = false
    else
      @return_value = true
    end
    render :inline => "<p id ='response'><%= @return_value %></p>"

  end



  #
  # 
  # FOLLOWING/FOLLOWER ACTIONS
  #
  #

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
  
  

  def show_followers
      @user_list = []
      @followers_not_followings = true
      for relationship_object in current_user.followers.all
        @user_list << User.find(relationship_object.follower_user_id) # add all followed users to list
      end    
      
      if @user_list == []
        redirect_to root_path, notice: "You don't have any followers yet"
      end
  end
  
  def show_following 
      @user_list = []
      @followers_not_followings = false
      for relationship_object in current_user.followings.all
        @user_list << User.find(relationship_object.followed_user_id) # add all followed users to list
      end
      
      if @user_list == []
        redirect_to root_path, notice: 'No users currently being followed'
      end
  end


  #
  # 
  # DESTROY USER
  #
  #

  def destroy
  end
end
