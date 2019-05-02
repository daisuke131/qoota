class Api::V1::ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :update, :destroy]

  def index
    @articles = Article.all
    render json: @articles
  end

  def show
    render json: @article
  end

  def create
    @article = current_user.articles.create!(article_params)
  end

  def update
    @article.update!(article_params)
  end

  def destroy
    @article.destroy!
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end