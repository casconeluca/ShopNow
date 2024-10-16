class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        format.html { redirect_to user, notice: "Logged in successfully" }
      else
        format.html { flash.now[:alert] = "Invalid email/password combination"; render :new, status: :unprocessable_content }
      end
    end
  end

  def destroy
    session[:user_id] = nil

    respond_to do |format|
      format.html { redirect_to root_path, status: :see_other, notice: "Logged out successfully" }
    end
  end
end

