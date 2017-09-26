class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    # binding.pry
    @page_title = "ユーザー情報"
    @user = User.find(params[:id])
    #Relationship.followedArticle(@user)
    @articles = Article.where(user_id:@user.id).order(updated_at: :desc).limit(5)

    @followUserArticle = @user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
    #@follow = @user.followers
    #@followed = @user.followed_users
  end
end
