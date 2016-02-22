class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    @events = Event.all
  end

  def show
#    @projects = Project.all(:team).where(event_id: @event)
    @projects = @event.projects
  end

  def projects
    @projects = Project.all
  end

  private
  def set_event
    @event = Event.find_by(code: params[:code].upcase)
  end
end
