class UserMailer < ActionMailer::Base
  default from: "atripavan@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  
  def password_reset(emailId, reset_token)
    @reset_token = reset_token
    mail :to => emailId, :subject => "WDI Prospects Browser - Password Reset"
  end

end
