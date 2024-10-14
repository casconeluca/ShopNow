class UsersController < ApplicationController
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

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end

