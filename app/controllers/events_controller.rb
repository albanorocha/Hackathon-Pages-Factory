class EventsController < ApplicationController
  before_action :set_event, only: [:show]

  def index
    @events = Event.where(published: true).paginate(:page => params[:page], :per_page => 6)
      .order('created_at DESC')
  end

  def show
#    @projects = Project.all(:team).where(event_id: @event)
    @projects = @event.projects
  end

  def projects
    @projects = Project.joins(team: :event).where(events: {published: true})
      .paginate(:page => params[:page], :per_page => 6).order('created_at DESC')
  end

  private
  def set_event
    @event = Event.find_by(code: params[:code].upcase)
  end
end
