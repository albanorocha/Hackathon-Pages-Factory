class Admin::TeamsController < Admin::AdminController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_event
  add_breadcrumb "Eventos", :admin_events_path

  # GET /teams
  # GET /teams.json
  def index
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    @teams = Team.where(event: @event)
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "#{@team.name}", :admin_event_team_path
    @team_users = TeamUser.where(team: @team)
  end

  # GET /teams/new
  def new
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "New Team", :new_admin_event_team_path
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "Edit Team", :edit_admin_event_team_path
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    @team.event = @event

    respond_to do |format|
      if @team.save
        format.html { redirect_to admin_event_team_path(@team, code: @event.code),
          notice: 'Equipe foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to admin_event_team_path(@team, code: @event.code) ,
          notice: 'Equipe foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to admin_event_teams_url, notice: 'Equipe foi EXCLUÍDO com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.find_by(code: params[:code].upcase)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end
end
