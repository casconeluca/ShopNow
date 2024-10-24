class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[ index show ]
  before_action :set_category, only: %i[ show edit update destroy ]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoria aggiunta con successo!"
      redirect_to @category
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Categoria aggiornata con successo!"
      redirect_to @category
    else
      render :edit, status: :unprocessable_content
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @products = @category.products.paginate(page: params[:page], per_page: 3)
  end

  def destroy
    @category.destroy
    flash[:notice] = "Categoria distrutta con successo!"
    redirect_to categories_path
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Non hai i permessi per farlo"
      redirect_to categories_path
    end
  end
end