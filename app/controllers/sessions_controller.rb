class SessionsController < ApplicationController

  def create
    #if @user.password == params[:password]
    # exceptionstring = ""
    # env["omniauth.auth"].each do |hash_element|
    #     exceptionstring += hash_element.to_s
    # end
    # raise exceptionstring
    
    request = env['omniauth.auth']
    
    # if user reached this URL by trying to register through facebook
    if params[:state] == "register"
      #facebook returns a name string of "FirstName LastName" - split into the array [FirstName, LastName]
      name = request.info.name.split
      respond_to do |format|
        format.html {return redirect_to fb_register_path+"?email="+request.info.email+"&firstname="+name[0]+"&lastname="+name[1]+"&facebook=true"}
      end
    end
    
    # tries to log the user in through facebook callback information
    unless request == nil
      user = User.find_by_email(request.info.email)
    end
    
    # if facebook information doesn't match an existing user,
    # try to log in using information from a login form
    if user == nil      
      user = User.login(params[:email], params[:password_hash])
      session[:facebook] = false
      
    # if facebook information resulted in successful login
    # store facebook parameters in current user 
    else
      user.facebook_id = request.extra.raw_info.id
      user.access_token = request.credentials.token
      session[:facebook] = true
      # user.token_expiry = request.credentials.expires_at
      user.save
    end
    
    # if a user with provided login information was found, create a session
    if user != false
      @logged_in = true
      session[:user_id] = user.id
      respond_to do |format|
        format.html {redirect_to root_path, :notice => "Logged in successfully"}
        format.js      
      end
      
    # if login fails, redirect to login page      
    else
      @logged_in = false
      respond_to do |format|
        format.html {render 'new', :notice => "Invalid username/password combination"}
        format.js  
      end
    end
  end

  def destroy
    reset_session
    respond_to do |format|
      format.html {redirect_to root_path, :notice => "You successfully logged out"}
      format.js 
    end
  end

  
  def new
    if params[:form_opened] == "true"
      @form_opened = true
    else
      @form_opened = false
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new_login_or_register #
    respond_to do |format|
      format.js 
    end
  end
  

  
end

