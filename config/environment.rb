# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Ideagarden::Application.initialize!

# Allowing ActionMailer to deliver mail through Gmail's SMTP server
#config.action_mailer.delivery_method = :smtp
#Raising errors on mail delivery (in general)
#config.action_mailer.raise_delivery_errors = true
    
#ActionMailer::Base.smtp_settings = {
#:address => "aspmx.l.google.com",
#:port => 25,
  
#}
    
