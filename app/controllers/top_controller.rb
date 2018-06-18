class TopController < ApplicationController
  def index
    if user_signed_in?
      #もう少し良い方法があれば変えてみること！
      @followUserArticle = current_user.followed_users.map{|user| {user_article: {name: user.name, artcles: user.articles}}}
      
      # What's New //TODO 機能追加時に共通化する
      @articles = Article.includes(:evaluates).where(user_id: current_user).order(updated_at: :desc).limit(5)
    end
  end
end
