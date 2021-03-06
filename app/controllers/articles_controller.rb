class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_article, only: %i[show edit update destroy]
  include ArticleSelect

  def index
    @user = User.find(params.values.first) if params.values.first.to_i != 0 
    # paramにidが存在しない = 全件表示 / idが渡らない場合1番目にはController名が来る

    @articles = article_selection
    # paramがuidかuser_idかでタグがarticleかevaluateかを判定
    # TODO// 別の方法を検討
    @tagId = params[:uid].blank?? "article" : "evaluate"
  end

  
  def show
    @like = Like.new
    @evaluate = @article.evaluates.where(user_id: @article.user_info).first
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: '投稿しました！' }
      else
        @article.errors.each do |name, msg|
          tName = t "activerecord.attributes.article.#{name}"
          @article.errors.messages[name] =  tName + msg
        end
        @article.errors.messages[:target] = "article"
        #非同期でエラーを表示させる
        format.js   { render json: @article.errors }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to root_path, notice: '修正完了しました！' }
      else
        @article.errors.each do |name, msg|
          tName = t "activerecord.attributes.article.#{name}"
          flash.now[name] = tName + msg
        end
        @article.errors.messages.each {
          |key, value|
          @article.errors.messages[key] = flash.now[key]
        }
        @article.errors.messages[:target] = "article"
        # 非同期でエラーを表示させる
        format.js   { render json: @article.errors }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: '削除が完了しました！' }
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(
      :name, :address, :tell, :art_comment, :source, :genre, :parking, 
      :station, :picture, :image_cache, :remove_image
      )
  end
end
