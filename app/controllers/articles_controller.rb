class ArticlesController < ApplicationController
  #index以外はログインしないとダメ
  before_action :authenticate_user!, except: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  # articles#indexは以下の2通り
  # articles_index GET    /articles/index(.:format)  ▶　全記事一覧
  # user_articles GET    /users/:user_id/articles(.:format) ▶　ユーザーの記事一覧

  def index
    @test ="testesteste"
    if params[:user_id]
      @user = User.find(params[:user_id])
      @articles = @user.articles
      #binding.pry
      respond_to do |format|
        format.js
      end
      #
    else
      #binding.pry
      @articles = Article.all
    end
  end

  def show
    @like = Like.new() # 追記
    #binding.pry
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id

    respond_to do |format|
      if @article.save
        format.html { redirect_to top_path, notice: '投稿しました！' }
        #format.json { render :show, status: :created, location: @article }
        #format.js { @status = "success"}
        binding.pry
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        #format.js { @status = "fail" }
        #binding.pry
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to top_path, notice: '修正完了しました！' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to top_url, notice: '削除が完了しました！' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
        # params.require(:picture).permit(:date)
        params.require(:article).permit(:name,:address,:tell,:art_comment,:source,:genre,:parking,:station,:picture,:image_cache, :remove_image)
    end
end
