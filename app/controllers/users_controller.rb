class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end



end

