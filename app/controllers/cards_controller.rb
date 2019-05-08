class CardsController < ApplicationController
  before_action :user_sign_in

  def index
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to mypage_card_path(current_user.id, current_user.id)
    end
  end

  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_mypage_card_path(current_user.id)
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @card = card
      @default_card_information = customer.cards.retrieve(card.card_id)
      @exp_month = @default_card_information.exp_month.to_s
      @exp_year = @default_card_information.exp_year.to_s.slice(2,3)
    end
  end

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to mypage_card_path(current_user.id, current_user.id) if card.exists?
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params[:payjp_token].blank?
      redirect_to new_mypage_card_path(current_user.id)
    else
      customer = Payjp::Customer.create(
        description: "登録テスト",
        card: params[:payjp_token],
        metadata: {user_id: current_user.id}
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to mypage_card_path(current_user.id, current_user.id)
      else
        redirect_to new_mypage_card_path(current_user.id)
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    card = Card.where(user_id: current_user.id).first
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to new_mypage_card_path(current_user.id)
  end

  private
  def user_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end

end
