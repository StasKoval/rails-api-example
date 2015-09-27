module Api
  module V1
    class ArticlesController < ApplicationController
      before_filter :restrict_access, except: [:show, :index]
      before_action :set_article,     only: [:show, :edit, :update, :destroy]
      load_and_authorize_resource

      # GET /articles
      # GET /articles.json
      def index
        @articles = Article.accessible_by(current_ability)
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
        def set_article
          @article = Article.find(params[:id])
        end

        def article_params
          params.require(:article).permit(:user_id, :content, :title)
        end
    end
  end
end
