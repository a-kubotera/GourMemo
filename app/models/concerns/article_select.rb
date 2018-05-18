module ArticleSelect
  extend ActiveSupport::Concern

  def set_articles
    # todo Routingを見直す
    if params[:user_id] || params[:uid]
      
      if params[:user_id] 
        # 投稿記事一覧
        @result = @user.articles + @user.liked_articles - @user.evaluated_articles
      else
        # 評価記事一覧
        @result = @user.evaluated_articles
      end
    else
      @q       = Article.search(params[:q])
      @q.sorts = 'id asc'
      @q.result(distinct: true)
    end
  end
end
