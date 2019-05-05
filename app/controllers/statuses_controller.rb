class StatusesController < ApplicationController

  def index
  end

  def show
    @item = Product.find(params[:id])
    @image = @item.images.first[:image]
    card = Card.where(user_id: 1).first
    if card.present?
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @card = card
    @default_card_information = customer.cards.retrieve(card.card_id)
    @exp_month = @default_card_information.exp_month.to_s
    @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def new
  end

  def pay
    card = Card.where(user_id: 1).first
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: params[:statuses][:amount],
      customer: card.customer_id,
      currency: "jpy"
    )
    buy_item = Status.new(buy_params)
    buy_item.save
    redirect_to root_path
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def buy_params
    params.require(:statuses).permit(:stage, :item_id, :buyer_id)
  end


end
