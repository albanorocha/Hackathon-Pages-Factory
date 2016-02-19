class HomeController < ApplicationController
  def index

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
