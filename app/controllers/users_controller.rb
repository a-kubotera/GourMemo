class UsersController < ApplicationController
  def index
    # TODO 条件未入力での検索をブロックしたい
    @q        = User.search(params[:q])
    @q.id_eq = 0 unless params[:q]
    @q.sorts = 'id asc'
    @users = @q.result(distinct: true)
  end

  def show
    @page_title = "ユーザー情報"
    @user = User.find(params[:id])

    # What's new //TODO 機能追加時に共通化する
    @articles = Article.includes(:evaluates).where(user_id: @user).order(updated_at: :desc).limit(5)

    @followUserArticle = @user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
    @follow = @user.followed_users
    @follower = @user.followers
  end
end
