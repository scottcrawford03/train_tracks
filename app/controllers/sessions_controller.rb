class SessionsController < ApplicationController
  def index
  end

  def create
    session[:return_to] = request.referer
    user = User.find_or_create_from_auth(auth)
    if user
      session[:user_id] = user.id
      redirect_to playlist_path(Playlist.last)
    else
      flash[:errors] = "Unable to Login to Spotify."
      redirect_to session[:return_to]
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
