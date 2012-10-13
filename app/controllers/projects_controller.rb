class ProjectsController < ApplicationController
  def index
    @projects = Project.open.page(params[:page])
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.save ? redirect_to(project_path(@project)) : render(:new)
  end
end
