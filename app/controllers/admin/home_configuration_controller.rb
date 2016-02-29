class Admin::HomeConfigurationController < Admin::AdminController
  before_action :set_home_configuration, only: [:index, :update]

  def index
    authorize @home_configuration
    add_breadcrumb "Home Configuration", :admin_home_configuration_path
  end

  def update
    authorize @home_configuration

    respond_to do |format|
      if @home_configuration.update(home_configuration_params)
        format.html { redirect_to admin_home_configuration_path, notice: 'Página Home foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: [:admin, @home_configuration] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @home_configuration].errors, status: :unprocessable_entity }
      end
    end

  end


  private
    def set_home_configuration
      @home_configuration = policy_scope(HomeConfiguration)
    end

    def home_configuration_params
      params.require(:home_configuration).permit(
        sliders_attributes: [:id, :title, :link, :description, :is_title_link,
          image_attributes: [:id, :image]])
    end
end
