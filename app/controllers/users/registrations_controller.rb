class Users::RegistrationsController < Devise::RegistrationsController
  def index
  end

  def create
    if params[:user][:password] == nil #sns登録なら
      password = params[:user][:password] = Devise.friendly_token.first(6) #deviseのパスワード自動生成機能を使用
      params[:user][:password_confirmation] = password
      super
      sns = SnsCredential.where(email: @user.email)
      sns.update(user_id:  @user.id)
    else #email登録なら
      super
    end
  end
end
