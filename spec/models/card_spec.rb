require 'rails_helper'

describe Card do

  describe "登録できる場合" do
    it "user_id, customer_id, card_id が全てnilでない" do
      card = build(:card)
      expect(card).to be_valid
    end
  end

  describe "登録できない場合" do
    it "user_idがnilの場合は登録できない" do
      card = build(:card, user_id: nil)
      card.valid?
      expect(card.errors[:user_id]).to include("can't be blank")
    end

    it "customer_idがnilの場合は登録できない" do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end

    it "card_idがnilの場合は登録できない" do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end

    it "user_idが空白スペースの場合は登録できない" do
      card = build(:card, user_id: " ")
      card.valid?
      expect(card.errors[:user_id]).to include("can't be blank")
    end

    it "customer_idが空白スペースの場合は登録できない" do
      card = build(:card, customer_id: " ")
      card.valid?
      expect(card.errors[:customer_id]).to include("can't be blank")
    end

    it "card_idが空白スペースの場合は登録できない" do
      card = build(:card, card_id: " ")
      card.valid?
      expect(card.errors[:card_id]).to include("can't be blank")
    end

    it "card_idが重複している時は登録できない" do
      card = create(:card)
      another_card = build(:card)
      another_card.valid?
      expect(another_card.errors[:card_id]).to include("has already been taken")
    end

  end
end
