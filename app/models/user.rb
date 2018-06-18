class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable
  mount_uploader :avatar, AvatarUploader
  has_many :articles, dependent: :destroy
  has_many :evaluates, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :likes, dependent: :destroy
  # throughを使って　ユーザー目線で、自分がいいね(like)した記事を liked_articles と呼ぶこととする。
  has_many :liked_articles, through: :likes, source: :article

  # ユーザー評価した記事を取得する
  has_many :evaluated_articles, through: :evaluates, source: :article

  # スコープmethod
  # ユーザーの記事全体の中から評価されたものだけ取得する
  def someone_evaluated
    articles.joins(:evaluates)
  end

  # facebookログイン
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.find_by(email: auth.info.email)
    unless user
      user = User.new(
          name:     auth.extra.raw_info.name,
          provider: auth.provider,
          uid:      auth.uid,
          email:    auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
          image_url:   auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save(validate: false)
    end
    user
  end
  # Twitterログイン
  def self.find_for_twitter_oauth(auth, signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    unless user
      # E-mailアドレス未登録の場合、自動生成する。これがないとサイレントエラーが発生する！
      email = auth.info.email.blank? ? "#{auth.uid}-#{auth.provider}@example.com" : auth.info.email
      user = User.new(
          name:     auth.info.nickname,
          image_url: auth.info.image,
          provider: auth.provider,
          uid:      auth.uid,
          email:    email ,
          password: Devise.friendly_token[0, 20]
      )
      user.skip_confirmation!
      user.save
    end
    user
  end
  # ランダムな文字列を出力
  def self.create_unique_string
      SecureRandom.uuid
  end
  # SNSログインしたユーザーの情報を変更できるように
  def update_with_password(params, *options)
    if provider.blank?
      super
    else
      params.delete :current_password
      update_without_password(params, *options)
    end
  end
  # 指定のユーザのフォロー
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  # フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  # 指定のユーザのフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  # イイねを解除する
  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end
end
