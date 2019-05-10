class ProductsController < ApplicationController

  before_action :set_parentCategory, only: [:index, :new, :create, :edit, :update]
  before_action :set_product, only: [:edit, :update]

  def index
    # 各カテゴリーの商品を無作為に４つずつ取得
    @products_ladies = Product.get_random_product(1)
    @products_mans = Product.get_random_product(2)
    @products_kids = Product.get_random_product(3)
    @products_interiors = Product.get_random_product(4)
    @products_books = Product.get_random_product(5)
    @products_toys = Product.get_random_product(6)
    @products_perfumes = Product.get_random_product(7)
    @products_appliances = Product.get_random_product(8)
  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @seller = User.find(@product.seller_id)
    @seller_items = Product.where(seller_id: @seller.id).where.not(id: @seller.id)
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
    if @product.update(product_update_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def edit
    @image_array1 = []
    @image_array2 = []
    @product.images[0...5].each do |img1|
      @image_array1 << img1
    end
    if @product.images.length > 5
      @product.images[5...10].each do |img2|
        @image_array2 << img2
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def set_parentCategory
    @parentCategories = Category.where(id: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 1001, 1101, 1201])
  end

  def product_params
    params.require(:product).permit(:name, :introduce, :price, :parent_category_id, :child_category_id, :grandchild_category_id, :shipping_method, :condition, :delivery_fee_payer, :area, :days_to_delivery, images_attributes: [:image]).merge(seller_id: current_user.id)
  end

  def product_update_params
    params.require(:product).permit(:name, :introduce, :price, :parent_category_id, :child_category_id, :grandchild_category_id, :shipping_method, :condition, :delivery_fee_payer, :area, :days_to_delivery, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end


  def set_product
    @product = Product.find(params[:id])
  end

end
