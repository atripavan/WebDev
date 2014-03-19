class PasswordResetsController < ApplicationController
  def new
  end
  
  #Create a reset token and email the user his reset_pwd link
  def create
    user = User.find_by_email(params[:email])
    if user
      user.password_reset_token = SecureRandom.urlsafe_base64
      user.password_reset_sent_at = Time.zone.now
      user.save(validate: false)
      UserMailer.password_reset(user.email, user.password_reset_token).deliver
      redirect_to log_in_path, :notice => "Email sent with password-reset instructions"
    else
      redirect_to log_in_path, :notice => "User for the given email not found. Please sign-up for access."
    end
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  #Check if reset token is longer than 2 hours and update if not
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has been expired"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit      
    end
  end
  
end
