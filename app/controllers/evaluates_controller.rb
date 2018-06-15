class EvaluatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: %i[index new edit create update]
  before_action :set_evaluate, only: %i[show edit update]

  def index
    @evaluates = @article.evaluates.where.not(user_id: @article.user_info)
  end

  def new
    @evaluate = current_user.evaluates.build
  end

  def create
    @evaluate = current_user.evaluates.build(evaluate_params)
    respond_to do |format|
      if @evaluate.save
        format.html { redirect_to root_path, notice: '評価しました！' }
      else
        @evaluate.errors.each do |name, msg|
          tName = t "activerecord.attributes.evaluate.#{name}"
          @evaluate.errors.messages[name] =  tName + msg
        end
        @evaluate.errors.messages[:target] = "evaluate"
        format.js   { render json: @evaluate.errors }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @evaluate.update(evaluate_params)
        format.html { redirect_to root_path, notice: '評価を修正しました！' }
      else
        @evaluate.errors.each do |name, msg|
          tName = t "activerecord.attributes.evaluate.#{name}"
          @evaluate.errors.messages[name] =  tName + msg
        end
        @evaluate.errors.messages[:target] = "evaluate"
        format.js { render json: @evaluate.errors }
      end
    end
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def set_evaluate
    @evaluate = Evaluate.find(params[:id])
  end

  def evaluate_params
    params.require(:evaluate)
      .permit(:date, :evaluate, :eva_comment)
      .merge(article_id: @article.id)
  end
end
