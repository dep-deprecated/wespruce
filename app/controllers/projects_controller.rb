class ProjectsController < ApplicationController

  DEFAULT_IP = ENV['USER_IP'] || '24.5.177.29'

  def index
    @user_latlng =  if params[:zipcode] =~ /\A\d{5}\Z/
                      geocode(params[:zipcode])
                    else
                      (request.remote_ip == '127.0.0.1') ? geocode(DEFAULT_IP) : request.location.data
                    end

    @projects = Project.open.
      near([@user_latlng['latitude'], @user_latlng['longitude']], 20, order: :distance).
      page(params[:page])
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

  def claim
    @project = Project.find(params[:id])
    current_user.claim_project(@project)
    redirect_to @project, notice: "You have claimed this project"
  end

  def unclaim
    @project = Project.find(params[:id])
    @project.unaccept!
    redirect_to @project, notice: "You have removed from this project"
  end

  def complete
    @project = Project.find(params[:id])
    @project.complete!
    redirect_to @project, notice: "You have marked this project as complete"
  end

  def verify
    @project = Project.find(params[:id])
    current_user.verify_project(@project)
    redirect_to @project, notice: "You have verified that this project is complete"
  end

  def edit
    @project = current_user.projects.find(params[:id])
    redirect_to(projects_path) unless @project
  end

  def update
    @project = current_user.projects.find(params[:id])
    redirect_to(projects_path) unless @project

    if @project.update_attributes(project_params)
      redirect_to(project_path(@project))
    else
      render(:edit)
    end
  end

private
  def geocode(query)
    begin
       data = Geocoder.search(query).first.data
       return data if data['latitude'] && data['longitude']

       { 'latitude' => data['geometry']['location']['lat'], 'longitude' => data['geometry']['location']['lng'] }
    rescue => e
      logger.debug("Failed to geocode #{query}")
      return nil
    end
  end

  def project_params
    params[:project].permit(:name, :description, :rating, :latitude, :longitude,
                            { photos_attributes: [:image, :kind] })
  end
end
