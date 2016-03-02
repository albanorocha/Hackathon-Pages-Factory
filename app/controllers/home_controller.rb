class HomeController < ApplicationController
  def index
    @home_configuration = HomeConfiguration.first
    @sliders = @home_configuration.sliders
  	@events = Event.where(published: true).paginate(:page => params[:page], :per_page => 6)
      .order('created_at DESC')
  end
end
