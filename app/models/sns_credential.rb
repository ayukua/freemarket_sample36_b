class SnsCredential < ApplicationRecord

  belongs_to :user, optional: true

  validates :name,     presence: true
  validates :email,     presence: true, uniqueness: true
  validates :provider,     presence: true
  validates :uid,     presence: true

  def self.find_for_facebook(auth)
    sns = SnsCredential.where(name: auth.info.name, uid: auth.uid, provider: auth.provider, email: auth.info.email).first_or_create

    if sns.user
      user = sns.user
    end

    unless user
      user = User.new(
                       nickname: auth.info.name,
                       email:    auth.info.email,
                      )

    end
    user
  end

  def self.find_for_google_oauth2(auth)
    sns = SnsCredential.where(name: auth.info.name, uid: auth.uid, provider: auth.provider, email: auth.info.email, token: auth.credentials.token).first_or_create

    # sns.usertがいるかどうかでif文を作る
    if sns.user
    # いる場合はそのユーザーをuserという変数に格納
      user = sns.user
    end

    # いなかった場合はUser.newしてauth.infoのnameとemailを入れておく
    unless user
      user = User.new(
                       nickname: auth.info.name,
                       email:    auth.info.email,
                      )

    end
    # メソッドの最後でuserを返す
    user
  end
end
