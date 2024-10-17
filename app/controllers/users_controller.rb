class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :require_user, only: %i[ edit update ]
  before_action :require_same_user, only: %i[ edit update destroy ]
  def show
    @products = @user.products.paginate(page: params[:page], per_page: 3)
  end
  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to products_path, notice: "Welcome #{@user.username}" }
      else
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "The account was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated products successfully deleted."
    redirect_to products_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own account"
      redirect_to @user
    end
  end


end

