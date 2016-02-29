class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:equipes,  :show, :edit, :edit_password, :update, :update_password, :destroy]
  add_breadcrumb "Usuários", :admin_users_path, only: [:index, :new]

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = policy_scope(User)
    authorize @users
  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
    add_breadcrumb "#{@user.name}", :admin_user_path
    authorize @user
  end

  # GET /admin/users/1/edit
  def equipes
    add_breadcrumb "Equipes", :equipes_admin_user_path
    @teams = current_user.teams
    authorize @user
  end

  # GET /admin/users/new
  def new
    add_breadcrumb "New User", :new_admin_user_path
    @user = User.new
    authorize @user
  end

  # GET /admin/users/1/edit
  def edit
    authorize @user

    add_breadcrumb "#{@user.name}", :admin_user_path
    add_breadcrumb "Edit User", :edit_admin_user_path
  end

  # GET /admin/users/1/edit
  def edit_password
    authorize @user

    add_breadcrumb "#{@user.name}", :admin_user_path
    add_breadcrumb "Edit Password", :edit_password_admin_user_path
  end

  # GET /admin/users/1/edit
  def update_password
    authorize @user

    respond_to do |format|
      if @user.update(permitted_attributes(@user))
        format.html { redirect_to admin_users_path, notice: 'Usuário foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: [:admin, @user] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @user].errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /admin/users
  # POST /admin/users.json
  def create
    @user = User.new()
    authorize @user

    respond_to do |format|
      if @user.update(permitted_attributes(@user))
        format.html { redirect_to admin_users_path, notice: 'Usuário foi CRIADO com sucesso.' }
        format.json { render :show, status: :created, location: [:admin, @user] }
      else
        format.html { render :new }
        format.json { render json: [:admin, @user].errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    authorize @user

    respond_to do |format|
      if @user.update(permitted_attributes(@user))
        format.html { redirect_to admin_user_path, notice: 'Usuário foi ATUALIZADO com sucesso.' }
        format.json { render :show, status: :ok, location: [:admin, @user] }
      else
        format.html { render :edit }
        format.json { render json: [:admin, @user].errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    authorize @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'Usuário foi EXCLUÍDO com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
    #  params.require(:user).permit(:name, :email, :password, :role)
    #end
end
