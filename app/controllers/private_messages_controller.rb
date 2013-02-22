class PrivateMessagesController < ApplicationController
  
  
  def index
    @private_messages = PrivateMessage.where(:user_id => current_user.id)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new #just load form - recipients can be added through ajax, like facebook
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @private_message = PrivateMessage.new(params[:private_message])
    if @private_message.save
      @message_saved = true
      respond_to do |format|
        format.html
        format.js
      end
    else
      @message_saved = false
      respond_to do |format|
        format.html
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
