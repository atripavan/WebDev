class SessionsController < ApplicationController
  def new
  end
  
  #Create a new session when user logs in
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_name] = user.name
      session[:user_email] = user.email
      redirect_to "/search"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  #Delete the session variable when user logs out
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end  
  
end
