require 'rails_helper'

RSpec.describe Status do
  describe "決済できる場合" do
    it "stage, item_id, buyer_id が存在する時に登録できる" do
      seller = create(:user)
      category = create(:category)
      product = create(:product, seller_id: seller.id)
      buyer = create(:user , id: "2", email: "test@gmail.com")
      status = build(:status, buyer_id: buyer.id, item_id: product.id)
      expect(status).to be_valid
    end
  end

  describe "決済できない場合" do
    it "item_idが空白の時は決済できない" do
      status = build(:status, item_id: nil)
      status.valid?
      expect(status.errors[:item_id]).to include("can't be blank")
    end

    it "stageが空白の時は決済できない" do
      status = build(:status, stage: nil)
      status.valid?
      expect(status.errors[:stage]).to include("can't be blank")
    end

    it "buyer_idが空白の時は決済できない" do
      status = build(:status, buyer_id: nil)
      status.valid?
      expect(status.errors[:buyer_id]).to include("can't be blank")
    end

  end
end
