class SessionsController < ApplicationController

  def create
    #if @user.password == params[:password]
    user = User.login(params[:email], params[:password_hash])
    if user != false
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email/password combination"
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, :notice => "You successfully logged out"
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
  
  def create_login_or_register
    if params[:password_confirmation_hash] == nil #if user isn't registering, then do the following
      
    end
  end
  
end


