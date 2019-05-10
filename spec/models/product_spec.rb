require 'rails_helper'

describe Product do

  describe "登録できる場合" do
    it "userが存在し、かつ、name, introduce, condition, delivery_fee_payer, shipping_method, area, days_to_delivery, price, seller_id, parent_category_id, child_category_id, grandchild_category_id  が全てnilでない" do
      user = create(:user)
      product = build(:product, seller_id: user.id)
      expect(product).to be_valid
    end
  end
  
  describe "登録できない場合" do
    it "nameがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end

    it "introduceがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, introduce: nil)
      product.valid?
      expect(product.errors[:introduce]).to include("can't be blank")
    end

    it "conditionがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, condition: nil)
      product.valid?
      expect(product.errors[:condition]).to include("can't be blank")
    end

    it "delivery_fee_payerがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, delivery_fee_payer: nil)
      product.valid?
      expect(product.errors[:delivery_fee_payer]).to include("can't be blank")
    end

    it "shipping_methodがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, shipping_method: nil)
      product.valid?
      expect(product.errors[:shipping_method]).to include("can't be blank")
    end

    it "areaがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, area: nil)
      product.valid?
      expect(product.errors[:area]).to include("can't be blank")
    end

    it "days_to_deliveryがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, days_to_delivery: nil)
      product.valid?
      expect(product.errors[:days_to_delivery]).to include("can't be blank")
    end

    it "priceがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, price: nil)
      product.valid?
      expect(product.errors[:price]).to include("can't be blank")
    end

    it "seller_idがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: nil)
      product.valid?
      expect(product.errors[:seller_id]).to include("can't be blank")
    end

    it "Userが存在しない場合は登録できない" do
      product = build(:product)
      product.valid?
      expect(product.errors[:user]).to include("must exist")
    end

    it "parent_category_idがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, parent_category_id: nil)
      product.valid?
      expect(product.errors[:parent_category_id]).to include("can't be blank")
    end

    it "child_category_idがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, child_category_id: nil)
      product.valid?
      expect(product.errors[:child_category_id]).to include("can't be blank")
    end

    it "grandchild_category_idがnilの場合は登録できない" do
      user = create(:user)
      product = build(:product, seller_id: user.id, grandchild_category_id: nil)
      product.valid?
      expect(product.errors[:grandchild_category_id]).to include("can't be blank")
    end
  end
end
