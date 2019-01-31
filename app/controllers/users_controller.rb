class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update destroy)
  before_action :logged_in_user, only: %i(index edit update destroy)
  before_action :correct_user,   only: %i(edit update)
  before_action :admin_user,     only: %i(destroy)

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page]
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to root_url
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success"
      redirect_to users_url
    else
      flash[:danger] = t ".fail"
      redirect_to users_url
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless @user && current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
