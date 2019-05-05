class ProductsController < ApplicationController
  def index
    @firstCategories = Category.where(id: [1,2,3,4,5,6,7,8,9,1001,1101,1201,10])
    # @firstCategories = Category.where(ancestry: nil)
    # @secondCategories = Category.where(ancestry: @firstCategories.ids)
    # @thirdCategories = Category.where(ancestry: @secondCategories.ids)
  end

  def show
    @item = Product.find(params[:id])
    @images = @item.images
    @seller = User.find(@item.seller_id)
    @seller_items = Product.where(seller_id: @seller.id).where.not(id: @seller.id)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save(item_params)
      # 商品の出品完了
      # モーダルウィンドウが出てくる
    else
      # 画面はそのままで保存できない旨のメッセージの表示
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduce, :price, :parent_category_id, :child_category_id, :grandchild_category_id, :shipping_method, :condition, :delivery_fee_payer, :area, :days_to_delivery, :image).merge(seller_id: current_user.id)
  end
end
