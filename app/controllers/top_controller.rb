class TopController < ApplicationController
  def index
    @users = User.all
  end

  def index2
    @user = current_user
    @page_title ='マイページ'
    #もう少し良い方法があれば変えてみること！
    @followUserArticle = @user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}

    #@follow = @user.followers
    #@followed = @user.followed_users
  end
end
