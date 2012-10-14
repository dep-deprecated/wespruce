class Users::RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password, :zip_code)
  end
  private :resource_params

protected
  def after_update_path_for(resource)
    projects_by_zipcode_path(resource.zip_code)
  end
end
