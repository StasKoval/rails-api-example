module Api
  module V1
    class ArticlesController < ApplicationController
      load_and_authorize_resource

      before_filter :restrict_access
      before_action :set_article, only: [:show, :edit, :update, :destroy]

      # GET /articles
      # GET /articles.json
      def index
        @articles = Article.all
        render json: @articles
      end

      # GET /articles/1
      # GET /articles/1.json
      def show
        render json: @article
      end

      # GET /articles/new
      def new
        @article = Article.new
      end

      # POST /articles
      # POST /articles.json
      def create
        @article = Article.new(article_params)

        if @article.save
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /articles/1
      # PATCH/PUT /articles/1.json
      def update
        if @article.update(article_params)
          render json: @article
        else
          render json: @article.errors, status: :unprocessable_entity
        end
      end

      # DELETE /articles/1
      # DELETE /articles/1.json
      def destroy
        @article.destroy
        render json: @article
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_article
          @article = Article.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def article_params
          params.require(:article).permit(:user_id, :content, :title)
        end
    end
  end
end
