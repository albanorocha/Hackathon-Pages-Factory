class Admin::TeamUsersController < Admin::AdminController
  before_action :set_team_user, only: [:show, :edit, :update, :destroy]
  before_action :set_event
  before_action :set_team
  add_breadcrumb "Eventos", :admin_events_path

  # GET /admin/team_users
  # GET /admin/team_users.json
  #def index
  #  @team_users = policy_scope(TeamUser.where(team: @team))

    #authorize @team, :show
  # end

  # GET /admin/team_users/new
  def new
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "#{@team.name}", admin_event_team_path(@team, code: @event.code)
    add_breadcrumb "New Member", :new_admin_event_team_user_path

    @team_user = TeamUser.new(team: @team)
    @users = Event.find_by_code(@event.code).users

    authorize @team_user
  end

  # GET /admin/team_users/1/edit
  def edit
    authorize @team_user

    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "#{@team.name}", admin_event_team_path(@team, code: @event.code)
    add_breadcrumb "Edit Member", :edit_admin_event_team_user_path
  end

  # POST /admin/team_users
  # POST /admin/team_users.json
  def create
    #@team_user = TeamUser.new(team_user_params)
    @team_user = TeamUser.new
    @team_user.user = User.find(team_user_params[:user])
    @team_user.role = TeamUser.roles[team_user_params[:role]]
    @team_user.team = Team.find(params[:event_team_id])
    authorize @team_user


    respond_to do |format|
      if @team_user.save
        format.html { redirect_to admin_event_team_path(@team, :code => @event.code),
          notice: 'Membro de Equipe foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: @team_user }
      else
        format.html { render :new }
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/team_users/1
  # PATCH/PUT /admin/team_users/1.json
  def update
    authorize @team_user

    respond_to do |format|
      if @team_user.update(team_user_params)
        format.html { redirect_to admin_event_team_path(@team, :code => @event.code),
          notice: 'Membro de Equipe foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: @team_user }
      else
        format.html { render :edit }
        format.json { render json: @team_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/team_users/1
  # DELETE /admin/team_users/1.json
  def destroy
    authorize @team_user

    @team_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_event_team_path(@team, :code => @event.code),
        notice: 'Membro de Equipe foi EXCLUÍDO com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find_by(code: params[:code].upcase)
    end

    def set_team
      @team = Team.find(params[:event_team_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_team_user
      @team_user = TeamUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_user_params
       params.require(:team_user).permit(:user, :role)
    end
end
