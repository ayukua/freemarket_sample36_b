class ProductsController < ApplicationController

  before_action :set_parentCategory, only: [:index, :new, :create, :edit, :update]

  def index
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path
    else
      render plain: @product.errors.inspect
    end
  end

  def update
  end

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def set_parentCategory
    @parentCategories = Category.where(id: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1001, 1101, 1201])
  end

  def product_params
    params.require(:product).permit(:name, :introduce, :price, :parent_category_id, :child_category_id, :grandchild_category_id, :shipping_method, :condition, :delivery_fee_payer, :area, :days_to_delivery, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

end
