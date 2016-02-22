class ProjectController < ApplicationController
  layout 'projects'

  def index
    @project = Project.find_by_name(params[:project_name].titleize.upcase)
    @sliders = @project.sliders
  end
end
