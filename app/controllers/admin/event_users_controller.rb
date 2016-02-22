class Admin::EventUsersController < Admin::AdminController
  before_action :set_event_user, only: [:show, :edit, :update, :destroy]
  before_action :set_event

  # GET /admin/event_users
  # GET /admin/event_users.json
  def index
    @event_users = EventUser.where(event: @event)
  end

  # GET /admin/event_users/1
  # GET /admin/event_users/1.json
  def show
  end

  # GET /admin/event_users/new
  def new
    @event_user = EventUser.new
    @users = User.all
  end

  # GET /admin/event_users/1/edit
  def edit
    @users = User.all
  end

  # POST /admin/event_users
  # POST /admin/event_users.json
  def create
    #@event_user = EventUser.new(event_user_params)
    @event_user = EventUser.new
    @event_user.user = User.find(event_user_params[:user])
    @event_user.role = EventUser.roles[event_user_params[:role]]
    @event_user.event = Event.find_by_code(params[:code].upcase)


    respond_to do |format|
      if @event_user.save
        format.html { redirect_to admin_event_users_path(:code => @event.code),
            notice: 'Event user was successfully created.' }
        format.json { render :show, status: :created, location:[:admin, @event_user] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @event_user].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/event_users/1
  # PATCH/PUT /admin/event_users/1.json
  def update
    respond_to do |format|
      if @event_user.update(event_user_params)
        format.html { redirect_to admin_event_users_url,
            notice: 'Event user was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_user }
      else
        format.html { render :edit }
        format.json { render json: @event_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/event_users/1
  # DELETE /admin/event_users/1.json
  def destroy
    @event_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_event_users_url, notice: 'Event user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find_by(code: params[:code].upcase)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event_user
      @event_user = EventUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_user_params
      params.require(:event_user).permit(:user, :role)
    end
end
