class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable,:omniauthable
  has_many :articles, dependent: :destroy
  has_many :evaluates, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower

  #イイネ機能
  has_many :likes, dependent: :destroy
  #throughを使って　ユーザー目線で、自分がいいね(like)した記事を liked_articles と呼ぶこととする。
  has_many :liked_articles, through: :likes, source: :article


  #指定のユーザのフォロー
  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  #フォローしているかどうかを確認する
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
  #指定のユーザのフォローを解除する
  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  #イイねを解除する
  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end
end
