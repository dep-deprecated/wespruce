class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize
  before_filter :set_page_vars

  delegate :allow?, to: :current_permission
  helper_method :allow?

private
  def current_permission
    @current_permission ||= Permissions.permission_for(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    unless current_permission.allow?(params[:controller], params[:action], current_resource)
      redirect_to root_url, alert: 'Not authorized.'
    end
  end
  def set_page_vars
    @body_class = [params[:controller], params[:action]].join(' ')
  end

end
