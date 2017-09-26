class LikesController < ApplicationController
  #ログインしないとイイねできないし、当然消せない
  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @article = Article.find(params[:article_id])
    @like = Like.new(
      article_id: params[:article_id],
      user_id: current_user.id
    )
    @like.save
    # redirect_to article_path(@articles)
  end

  def destroy
    @like = Like.find_by(article_id: params[:article_id], user_id: current_user.id)
    #binding.pry
    @like.destroy
  end

  private
  def like_params
    params.require(:like).permit(:article_id, :user_id)
  end
end
