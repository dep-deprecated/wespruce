class LeaderboardController < ApplicationController
  def index
    @users = User.order('points DESC').page(params[:page])
  end

  def by_zipcode
    @users = User.where(zip_code: params[:zipcode]).order("points DESC").page(params[:page])
    render :index
  end
end
