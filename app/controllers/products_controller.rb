class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]
  before_action :require_user, except:  %i[ show index ]
  before_action :require_same_user, only: %i[ edit update destroy ]
  def show
  end
  def index
    @products = Product.paginate(page: params[:page], per_page: 3)
  end
  def new
    @product = Product.new
  end
  def edit
  end
  def create
    @product = Product.new(product_params)
    @product.user = current_user
    if @product.save
      flash[:notice] = "Product was created successfully."
      redirect_to @product
    else
      render :new
    end
  end
  def update
    if @product.update(product_params)
      flash[:notice] = "Product was updated successfully."
      redirect_to @product
    else
      render :edit
    end
  end
  def destroy
    @product.destroy!
    flash[:notice] = "Product was successfully destroyed."
    redirect_to products_path
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    def product_params
      params.require(:product).permit(:name, :description, :price)
    end
    def require_same_user
      if current_user != @product.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own products"
        redirect_to @product
      end
    end
end
