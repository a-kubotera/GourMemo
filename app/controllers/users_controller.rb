class UsersController < ApplicationController
  def index
    @q        = User.search(params[:q])
    @q.id_eq = 0 unless params[:q]
    @q.sorts = 'id asc'
    @users = @q.result(distinct: true)
    @message = ""
    @message = '条件にHITするユーザーは存在しません。' if @users.count == 0
  end

  def show
    # binding.pry
    @page_title = "ユーザー情報"
    @user = User.find(params[:id])
    #Relationship.followedArticle(@user)
    @articles = Article.where(user_id:@user.id).order(updated_at: :desc).limit(5)

    @followUserArticle = @user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
    @follow = @user.followed_users
    @follower = @user.followers
  end
end
