class LeaderboardController < ApplicationController

  skip_before_filter :authorize

  def by_zipcode
    @users = User.where(zip_code: params[:zipcode]).order("points DESC").page
  end
end
