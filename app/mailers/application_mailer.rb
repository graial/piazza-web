class ApplicationMailer < ActionMailer::Base
  default from: "support@piazza.com"
  
  layout "mailer"
end
