class SessionsController < ApplicationController

  def create
    #if @user.password == params[:password]
    user = User.login(params[:email], params[:password_hash])
    if user != false
      @logged_in = true
      session[:user_id] = user.id
      respond_to do |format|
        format.html {redirect_to root_path, :notice => "Logged in successfully"}
        format.js      
      end
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

