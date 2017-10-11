class EvaluatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_evaluate, only: [:show, :edit, :update, :destroy]

  def index
     @article = Article.find(params[:article_id])
     @evaluates = @article.evaluates.where.not(user_id:@article.user_info.id)
  end

  def show
  end

  def new
    @evaluate = Evaluate.new
    @article = Article.find(params[:article_id])
  end

  def create
    @article = Article.find(params[:article_id])
    @evaluate = Evaluate.new(evaluate_params)
    @evaluate.user_id = current_user.id
    @evaluate.article_id = @article.id

    respond_to do |format|
      if @evaluate.save
        format.html { redirect_to top_path, notice: '評価しました！' }
      else
        format.html { render :new }
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
    @article = @evaluate.article
  end

  def update
        @article = Article.find(params[:article_id])
    respond_to do |format|
      if @evaluate.update(evaluate_params)
        format.html { redirect_to top_path, notice: '評価を修正しました！' }
        format.json { render :show, status: :ok, location: @evaluate }
      else
        format.html { render :new }
        @evaluate.errors.each do |name, msg|
          tName = t "activerecord.attributes.evaluate.#{name}"
          @evaluate.errors.messages[name] =  tName + msg
        end
        @evaluate.errors.messages[:target] = "evaluate"
        format.js   { render json: @evaluate.errors }
      end
    end
  end

  def set_evaluate
    @evaluate = Evaluate.find(params[:id])
  end

  def evaluate_params
      # params.require(:picture).permit(:date)
      params.require(:evaluate).permit(:date,:evaluate,:eva_comment)
  end
end
