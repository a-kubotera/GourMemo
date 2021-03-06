class Article < ActiveRecord::Base
  has_many :evaluates, dependent: :destroy
  # 1件の記事を複数の人がLikeできる
  has_many :likes, dependent: :destroy

  # 1件の記事が持つ複数のlikesを介して、複数のusersとつながっている　▶　この記事にいいねした全てのユーザー
  # throughを使って　記事目線で、いいね(like)を経由したユーザーを liked_users　と呼ぶこととする。
  has_many :liked_users, through: :likes, source: :user

  # ARTICLEのユーザー情報なので、User_infoとする。
  belongs_to :user_info, class_name: :User, foreign_key: :user_id

  # エラーチェック
  validates :user_id, presence: true
  validates :name, presence: true
  validates :address, presence: true
  validates :tell, presence: true
  # validates :picture, presence: true
  validates :genre, presence: true
  validates :parking, presence: true
  validates :station, presence: true
  validates :art_comment, presence: true
  validates :source, presence: true

  # アプローダー設定
  mount_uploader :picture, AvatarUploader

  # ジャンルの設定
  enum genre: %i[未設定 和食 中華 フレンチ カフェ ファストフード ]
  # パーキングの設定
  enum parking: %i[不明 無し 専用駐車場あり 近くにコインパーキングあり]


end
