class UserController < ApplicationController
  def show
    if current_user && params[:user].to_i == current_user.id
      @user = User.find(current_user.id)
    else
      redirect_to root_path
      flash[:error] = "You cannot view that page."
    end
  end
end