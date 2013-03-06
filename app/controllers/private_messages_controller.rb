class PrivateMessagesController < ApplicationController
  before_filter :login_filter
  before_filter :registration_filter
  
  def index
    @tags = []
    for posting in current_user.idea_postings
      @tags << posting.name
    end
    @private_messages = PrivateMessage.where(:recipient_id => current_user.id)
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @private_messages}
    end
  end
  
  def new #just load form - recipients can be added through ajax, like facebook
    @private_message = PrivateMessage.new
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def filter
    render :nothing => true
  end
  
  def create
    @private_message = PrivateMessage.new(params[:private_message])
    @private_message.user_ids << params[:recipient_ids]
    if @private_message.save
      @message_saved = true
      respond_to do |format|
        format.html {redirect_to private_messages_path, notice: "Message sent"}
        format.js
      end
    else
      @message_saved = false
      respond_to do |format|
        format.html {redirect_to new_private_message_path, notice: "Errors prevented your message from being sent"}
        format.js
      end
    end
  end
  
  def destroy
    @private_message = PrivateMessage.find(params[:id])
    if @private_message.destroy
      respond_to do |format|
        format.html
      end
    else
      
    end
  end
  
  
  
  
  
  
  
  
  
  
end
