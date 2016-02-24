class Admin::ProjectsController < Admin::AdminController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :set_event
  before_action :set_team
  add_breadcrumb "Eventos", :admin_events_path


  # GET /admin/projects
  # GET /admin/projects.json
  def index
    @projects = Project.where(team: @team)
  end

  # GET /admin/projects/1
  # GET /admin/projects/1.json
  def show
  end

  # GET /admin/projects/new
  def new
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "#{@team.name}", admin_event_team_path(@team, code: @event.code)
    add_breadcrumb "New Project", :new_admin_event_team_project_path

    @project = Project.new
  end

  # GET /admin/projects/1/edit
  def edit
    add_breadcrumb "#{@event.code}", :admin_event_path
    add_breadcrumb "Equipes", :admin_event_teams_path
    add_breadcrumb "#{@team.name}", admin_event_team_path(@team, code: @event.code)
    add_breadcrumb "Edit Project", :edit_admin_event_team_project_path

    @project.images.order('image DESC')
  end

  # POST /admin/projects
  # POST /admin/projects.json
  def create
    @project = Project.new(project_params)
    @project.create_images
    @project.create_slides

    @project.team = @team
    @project.name.upcase!

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_admin_event_team_project_path(@project, :code => @event.code,
          :event_team_id => @team) , notice: 'Projeto foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/projects/1
  # PATCH/PUT /admin/projects/1.json
  def update
    @project.name.upcase!
    respond_to do |format|
      if @project.update_attributes(project_params)
        format.html { redirect_to admin_event_team_path(@team, :code => @event.code),
          notice: 'Projeto foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/projects/1
  # DELETE /admin/projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admin_event_team_path(@team, :code => @event.code),
        notice: 'Projeto foi EXCLUÍDO com sucesso.' }
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
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:id, :name, :description, :problem, :solution, :team_description,
        :facebook_link, :instagram_link, :youtube_link, :email,
        sliders_attributes: [:id, :title, :link, :description, :is_title_link,
          image_attributes: [:id, :image]], images_attributes: [:id, :image] )
    end
end
