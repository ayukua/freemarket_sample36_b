require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  describe "GET #index" do
    # userをFactoryBotで作る
    before do
      user = FactoryBot.create(:user)
    # 作ったユーザでログインする
      sign_in user
    end

    it "can get it" do
      get :index
      # 出力結果
      expect(response).to render_template :index
    end
  end
end
