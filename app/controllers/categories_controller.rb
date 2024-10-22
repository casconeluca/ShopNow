class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[ index show ]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully added!"
      redirect_to @category
    else
      render :new, status: :unprocessable_content
    end
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.paginate(page: params[:page], per_page: 3)
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You are not allowed to do that."
      redirect_to categories_path
    end
  end
end