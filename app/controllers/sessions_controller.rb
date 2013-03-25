class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to users_path, :notice => "Logged in!"
      else
        redirect_to user_path(user), :notice => "Logged in!"
      end

    else
      flash.now.alert = "Invalid login or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end