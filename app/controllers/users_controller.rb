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
  def edit
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Benvenuto #{@user.username}, ti sei correttamente registrato"
      redirect_to products_path
    else
      render :new, status: :unprocessable_content
    end
  end
  def update
      if @user.update(user_params)
        flash[:notice] = "Le informazioni del tuo account sono state aggiornate con successo"
        redirect_to @user
      else
        render :edit, status: :unprocessable_content
      end
  end
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "L'account e tutti i prodotti associati sono stati eliminati con successo"
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
      flash[:alert] = "Puoi modificare o eliminare solo il tuo account"
      redirect_to @user
    end
  end
end
