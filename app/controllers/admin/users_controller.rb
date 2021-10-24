class Admin::UsersController < Admin::ApplicationController
  before_action :set_admin_user, only: %i[edit update destroy]

  def index
    authorize [:admin, User]
    @admin_users = policy_scope(
                     User,
                     policy_scope_class: Admin::UserPolicy::Scope
                   ).all
  end

  def new
    authorize [:admin, User]
    @admin_user = User.new
  end

  def edit; end

  def create
    @admin_user = User.new(admin_user_params)
    authorize [:admin, @admin_user]

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: admin_users_path }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_users_path, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: admin_users_path }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_admin_user
    @admin_user = authorize [:admin, User.find(params[:id])]
  end

  def admin_user_params
    params.require(:user).permit(:name, :email)
  end
end
