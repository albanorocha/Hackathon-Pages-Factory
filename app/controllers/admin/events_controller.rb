class Admin::EventsController < Admin::AdminController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Eventos", :admin_events_path

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    add_breadcrumb "#{@event.code}", :admin_event_path
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.build_image
  end

  # GET /events/1/edit
  def edit
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Edit", :edit_admin_event_path
    if @event.image.nil?
      @event.build_image
    end
  end


  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.code.upcase!

    user = @event.event_users.build
    user.user = current_user
    user.role = 1

    respond_to do |format|
      if @event.save
        format.html { redirect_to [:admin, @event], notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @event] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @event].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.code.upcase!
        format.html { redirect_to [:admin, @event], notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @event] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @event].errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by(code: params[:code].upcase)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:code, :name, :date, :address, :description,
        :release_sign_up, :published, image_attributes: [:image])
    end
end
