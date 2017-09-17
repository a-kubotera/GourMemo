class LikesController < ApplicationController
  #ログインしないとイイねできないし、当然消せない
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @articles = Article.find(params[:article_id])
    @like = Like.new(
      article_id: params[:article_id],
      user_id: current_user.id
    )
    if @like.save
      redirect_to article_path(@articles)
    else
      render template: 'articles/show'
    end
  end
  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    #binding.pry
    @like.destroy
    redirect_to article_path(params[:article_id])
  end

  private
  def like_params
    params.require(:like).permit(:article_id, :user_id)
  end
end
