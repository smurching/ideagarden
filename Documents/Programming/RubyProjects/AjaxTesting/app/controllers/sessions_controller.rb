class SessionsController < ApplicationController
  include BCrypt
  def create
    #if @user.password == params[:password]
    user = User.login(params[:email], params[:password])
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
  
end


