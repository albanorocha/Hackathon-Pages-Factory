class HomeController < ApplicationController
  def index
    @home_configuration = HomeConfiguration.first
    @sliders = @home_configuration.sliders
  	@events = Event.all
  end



    def show
  #    @projects = Project.all(:team).where(event_id: @event)
      @projects = @event.projects
    end

    def projects
      @projects = Projects.all
    end


end
