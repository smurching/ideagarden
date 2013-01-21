class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  before_filter :login_filter, :except => [:new, :create]
  def index
    @user = User.find(params[:user_id])
    @profile = @user.profile

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.json
  def new
    @user = User.find(params[:user_id])
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @user = User.find(params[:user_id])
    @profile = @user.build_profile(params[:profile])

    respond_to do |format|
      @user.confirmation_code = Array.new(20).map{rand(10)}.join
      UserMailer.welcome_email(@user).deliver
      if @profile.save && @user.save 
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
        format.html { redirect_to root_path, notice: 'Profile was successfully created. '+@registration_string }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end
