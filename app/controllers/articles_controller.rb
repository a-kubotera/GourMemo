class ArticlesController < ApplicationController
  #index以外はログインしないとダメ
  before_action :authenticate_user!, except: [:index]

  # articles#indexは以下の2通り
  # articles_index GET    /articles/index(.:format)  ▶　全記事一覧
  # user_articles GET    /users/:user_id/articles(.:format) ▶　ユーザーの記事一覧

  def index
    @test ="testesteste"
    if params[:user_id]
      @user = User.find(params[:user_id])
      @articles = @user.articles
      respond_to do |format|
        format.js
      end
      #binding.pry
    else
      # binding.pry
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
    @like = Like.new() # 追記
    #binding.pry
  end

  def new

  end

  def confirm
  end
end
