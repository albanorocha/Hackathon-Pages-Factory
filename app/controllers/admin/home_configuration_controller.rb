class Admin::HomeConfigurationController < Admin::AdminController
  before_action :set_home_configuration, only: [:index, :update]

  def index
  end

  def update
    respond_to do |format|
      if @home_configuration.update(home_configuration_params)
        format.html { redirect_to admin_home_configuration_path, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: [:admin, @home_configuration] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @home_configuration].errors, status: :unprocessable_entity }
      end
    end

  end


  private
    def set_home_configuration
      @home_configuration = HomeConfiguration.first
    end

    def home_configuration_params
      params.require(:home_configuration).permit(
        sliders_attributes: [:id, :title, :link, :description, :is_title_link,
          image_attributes: [:id, :image]])
    end
end
