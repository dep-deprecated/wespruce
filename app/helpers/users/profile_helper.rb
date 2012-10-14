module Users::ProfileHelper
  def user_in_top_3?
    User.where(zip_code: @user.zip_code).order("points DESC").limit(3).include?(@user)
  end

  def place
    case top_3_users.index(@user)
    when 0
      "first"
    when 1
      "second"
    when 2
      "third"
    end

  end

  def top_3_users
    User.where(zip_code: @user.zip_code).order("points DESC").limit(3)
  end
end
