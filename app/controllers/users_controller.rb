class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :user

  layout "control_panel"

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to users_path, :alert => I18n.t("structures.users.lost")
  end

  before_filter do
    add_breadcrumb "control_panel.index", :cp_path, :titled => true
    add_breadcrumb "users.index", :users_path, :titled => true
  end

  def index
    @users = User.order("email ASC").all
  end

  def show
    @user = User.find params[:id]

    add_breadcrumb show_title
  end
  def show_title
    get_title_by_code "users.show", :name => @user.email
  end

  def new
    @user = User.new

    add_breadcrumb new_title
  end
  def new_title
    get_title_by_code "users.new"
  end

  def create
    @user = User.new params[:user]

    @user.skip_confirmation!

    if @user.save
      redirect_to @user,  flash: {:notice => I18n.t("structures.users.create.ok")}
    else
      render 'new'
    end
  end
  def create_title
    new_title
  end

  def edit
    @user = User.find params[:id]

    add_breadcrumb edit_title
  end
  def edit_title
    get_title_by_code "users.edit"
  end

  def update
    @user = User.find params[:id]

    if params[:user][:password].blank?
      res = @user.update_without_password params[:user]
    else
      res = @user.update params[:user]
    end

    if res
      flash[:notice] = I18n.t("structures.users.update.ok")
    end

    render 'edit'
  end
  def update_title
    edit_title
  end

  def confirm
    @user = User.find params[:id]

    if @user.blank?
      flash[:alert] = I18n.t("structures.users.lost")

      redirect_to users_path
    elsif @user.confirm!
      flash[:notice] = I18n.t("structures.users.confirme.ok")
    else
      flash[:alert] = I18n.t("structures.users.confirme.fail")
    end

    redirect_to user_path(@user)
  end

  def destroy
    if allow_delete? params[:id]
      @user = User.find(params[:id])

      @user.destroy

      redirect_to users_path, flash: {:notice => I18n.t("structures.users.delete.ok")}
    else
      redirect_to users_path, flash: {:alert => I18n.t("structures.users.delete.own")}
    end
  end

  helper_method :allow_delete?
  def allow_delete? id
    id != current_user.id && id != 1
  end

  protected
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, {:role_ids => []})
  end
end