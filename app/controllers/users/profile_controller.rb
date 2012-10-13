class Users::ProfileController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    redirect_to root_path unless @user
  end
end
