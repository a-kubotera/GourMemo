class Article < ActiveRecord::Base
  has_many :evaluates, dependent: :destroy
  #1件の記事を複数の人がLikeできる
  has_many :likes
  #1件の記事が持つ複数のlikesを介して、複数のusersとつながっている　▶　この記事にいいねした全てのユーザー
  #throughを使って　記事目線で、いいね(like)を経由したユーザーを liked_users　と呼ぶこととする。
  has_many :liked_users, through: :likes, source: :user

  # ARTICLEのユーザー情報なので、User_infoとする。
  belongs_to :user_info, class_name: :User, foreign_key: :user_id
end
