class SessionsController < ApplicationController
  def index
  end

  def create
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
