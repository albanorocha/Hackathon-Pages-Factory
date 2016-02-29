class Admin::EventUsersController < Admin::AdminController
  before_action :set_event_user, only: [:edit, :update, :destroy]
  before_action :set_event
  add_breadcrumb "Eventos", :admin_events_path

  # GET /admin/event_users
  # GET /admin/event_users.json
  def index
    #@event_users = EventUser.where(event: @event)
    #@event_users = EventUserPolicy::Scope.new(current_user, [:admin, EventUser]).resolve
    @event_users = policy_scope(EventUser.where(event: @event))
    authorize @event_users

    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Usuários", :admin_event_users_path
  end


  # GET /admin/event_users/new
  def new
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Usuários", :admin_event_users_path
    add_breadcrumb "New Event", :new_admin_event_user_path
    @event_user = EventUser.new(event: @event)
    authorize @event_user
    @users = User.all
  end

  # GET /admin/event_users/1/edit
  def edit
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Usuários", :admin_event_users_path
    add_breadcrumb "Edit Event", :edit_admin_event_user_path
    @users = User.all
    authorize @event_user
  end

  # POST /admin/event_users
  # POST /admin/event_users.json
  def create
    #@event_user = EventUser.new(event_user_params)
    @event_user = EventUser.new(event: @event)
    authorize @event_user


    @event_user.user = User.find(permitted_attributes(@event_user)[:user])
    @event_user.role = EventUser.roles[permitted_attributes(@event_user)[:role]]


    respond_to do |format|
      if @event_user.save
        format.html { redirect_to admin_event_users_path(:code => @event.code),
            notice: 'Paticipante foi CRIADO com sucesso.' }
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
    authorize @event_user

    respond_to do |format|
      if @event_user.update(permitted_attributes(@event_user))
        format.html { redirect_to admin_event_users_url,
            notice: 'Paticipante foi ATUALIZADO com sucesso.' }
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
    authorize @event_user

    @event_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_event_users_url, notice: 'Paticipante foi EXCLUÍDO com sucesso.' }
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
    #def event_user_params
    #  params.require(:event_user).permit(:user, :role)
    #end
end
