class ProjectsController < ApplicationController

  DEFAULT_IP = ENV['USER_IP'] || '24.5.177.29'

  def index
    @projects = Project.open.page(params[:page])

    ip = (request.remote_ip == '127.0.0.1') ? DEFAULT_IP : request.remote_ip
    @geodata = geocode_ip(ip)
    @user_latlng = @geodata.select { |k,v| %w(latitude longitude).include?(k) } if @geodata
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new(latitude: request.location.latitude, longitude: request.location.longitude)
  end

  def create
    @project = current_user.created_projects.new(project_params)
    @project.save ? redirect_to(project_path(@project)) : render(:new)
  end

private

  def project_params
    params[:project].permit(:name, :description, :rating, :latitude, :longitude)
  end

end
