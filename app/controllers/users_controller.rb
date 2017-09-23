class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @page_title = "ユーザー情報"
    @user = User.find(params[:id])
    #Relationship.followedArticle(@user)

    @followUserArticle = @user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
    #@follow = @user.followers
    #@followed = @user.followed_users
  end
end
