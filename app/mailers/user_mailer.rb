class UserMailer < ActionMailer::Base
  default from: "registration@ideagarden.com"
  
   def welcome_email(user)    
     @user = user    
     mail :to => user.email, :subject => "Welcome to Ideagarden!", :sent_on => Time.now, :from => "Ideagarden"
   end
   
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset Request"
  end
end


  def confirmation_email(user)
   recipients "#{user.name} <#{user.email}>"
    from       "My Forum "
    subject    "Please activate your new account"
    sent_on    Time.now
  end
