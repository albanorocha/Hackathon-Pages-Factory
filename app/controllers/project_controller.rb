class ProjectController < ApplicationController
  layout 'projects'

  def index
    @project = Project.find_by_path(params[:project_name])
    @sliders = @project.sliders
  end
end
