class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Accesso effettuato con successo"
      redirect_to user
    else
      flash.now[:alert] = "Attenzione i dati inseriti non sono corretti"
      render :new, status: :unprocessable_content
    end
  end
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Disconnesso correttamente"
    redirect_to root_path
  end
end

