require 'rails_helper'
describe SnsCredential do

  describe '登録できる場合' do
    it "name, email, provider, uid が全てnilでない" do
      sns_credential = build(:sns_credential)
      expect(sns_credential).to be_valid
    end
  end

  describe "登録できない場合" do
    it "nameがnilの場合は登録できない" do
      sns_credential = build(:sns_credential, name: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:name]).to include("can't be blank")
    end

    it "eamilがnilの場合は登録できない" do
      sns_credential = build(:sns_credential, email: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:email]).to include("can't be blank")
    end

    it "providerがnilの場合は登録できない" do
      sns_credential = build(:sns_credential, provider: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:provider]).to include("can't be blank")
    end

    it "uidがnilの場合は登録できない" do
      sns_credential = build(:sns_credential, uid: nil)
      sns_credential.valid?
      expect(sns_credential.errors[:uid]).to include("can't be blank")
      end

    it "emailが重複する場合は登録できない" do
      sns_credential = create(:sns_credential)
      another_user = build(:sns_credential, email: sns_credential.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
  end
end

