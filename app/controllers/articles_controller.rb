class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    a =[]
    
    if params[:user_id]
      @user = User.find(params[:user_id])
      @tagId="article"
      #@userの書いた記事をマップして、@userが評価していない記事を a[]に収納する
      @user.articles.map{|article| a << article if article.evaluates.where(user_id: article.user_info.id).blank?}
      @is_ArtCnt = a.length == 0
      #binding.pry
    elsif params[:uid]
      @user = User.find(params[:uid])
      @tagId="evaluate"
      #形式を合わせるためにaに収納
      a = @user.articles_evaluated
      @is_EvaCnt = a.length == 0
    else
      @q        = Article.search(params[:q])
      @q.sorts = 'id asc'
      a = @q.result(distinct: true)
    end
    @articles = a
  end

  def show
    @like = Like.new
    @evaluate = @article.evaluates.where(user_id:@article.user_info.id).first
    #イイねした人だけが評価できる
    #@likesEvaluate =  @article.likes.where(user_id:current_user.id)
  end

  def new
    @article = Article.new
    @article.user_id = current_user.id
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: '投稿しました！' }
      else
        format.html { render :new }
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
        format.html { render :new }
        @article.errors.each do |name, msg|
          tName = t "activerecord.attributes.article.#{name}"
          flash.now[name] = tName + msg
        end
        @article.errors.messages.each {
           |key, value|
           @article.errors.messages[key] = flash.now[key]
         }
        @article.errors.messages[:target] = "article"
        #非同期でエラーを表示させる
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
      params.require(:article).permit(:name,:address,:tell,:art_comment,:source,:genre,:parking,:station,:picture,:image_cache, :remove_image)
    end
end
