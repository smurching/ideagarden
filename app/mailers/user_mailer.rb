class UserMailer < ActionMailer::Base
  default from: "registration@ideagarden.com"
  
   def welcome_email(user)    
     @user = user    
     mail :to => user.email, :subject => "Welcome to Ideagarden!"
   end
   
  def reset_password(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset Request"
  end
end



