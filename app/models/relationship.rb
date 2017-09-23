class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  def self.followedArticle(aaaa)
    @followUserArticle = aaaa.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
  end
end
