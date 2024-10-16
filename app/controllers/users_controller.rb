class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @products = @user.products
  end

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to products_path, notice: "Welcome #{@user.username}" }
      else
        format.html { render :new, status: :unprocessable_content }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to products_path, notice: "The account was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_content }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end

