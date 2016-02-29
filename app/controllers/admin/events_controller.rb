class Admin::EventsController < Admin::AdminController
  before_action :set_event, only: [:event_subscribe, :show, :edit, :update, :destroy]
  add_breadcrumb "Eventos", :admin_events_path

  # GET /events
  # GET /events.json
  def index
    #@events = Event.all
    @events = policy_scope(Event)
    authorize @events
  end

  # GET /events/1
  # GET /events/1.json
  def show
    add_breadcrumb "#{@event.code}", :admin_event_path
    authorize @event
  end

  # GET /events/new
  def new
    add_breadcrumb "Novo Evento", :new_admin_event_path
    @event = Event.new
    authorize @event

    @event.build_image
  end

  # GET /events/1/edit
  def edit
    authorize @event

    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Edit Evento", :edit_admin_event_path
    if @event.image.nil?
      @event.build_image
    end
  end

  def event_subscribe
    authorize @event

    @event.users << current_user
    respond_to do |format|
      if @event.save
        format.html { redirect_to [:admin, @event], notice: 'Inscrição realizada com sucesso.' }
        format.json { render :show, status: :created, location: [:admin, @event] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @event].errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new()
    authorize @event

    @event = Event.new(permitted_attributes(@event))

    @event.code.upcase!

    if @event.image.nil?
      @event.create_image
    end

    user = @event.event_users.build
    user.user = current_user
    user.role = 1

    respond_to do |format|
      if @event.save
        format.html { redirect_to [:admin, @event], notice: 'Evento foi CRIADO com sucesso.' }
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
    authorize @event

    respond_to do |format|
      if @event.update(permitted_attributes(@event))
        @event.code.upcase!
        format.html { redirect_to [:admin, @event], notice: 'Evento foi ATUALIZADO com sucesso.' }
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
    authorize @event

    @event.destroy
    respond_to do |format|
      format.html { redirect_to admin_events_url, notice: 'Evento foi EXCLUÍDO com sucesso.' }
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
