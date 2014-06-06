module Api
  module V1
    class ArticlesController < ApplicationController

      include ActionController::MimeResponds
      before_action :set_article, only: [:update, :destroy, :show]

      # GET /blog/:blog_id/articles or GET /articles
      # GET /blog/:blog_id/articles.xml or GET /articles.xml
      def index
        params[:blog_id].present? ? @articles = Blog.find(params[:blog_id]).articles : @articles = Article.all

        respond_to do |format|
          format.json { render json: @articles }
          format.xml { render xml: @articles }
        end
      end

      # GET articles/1
      # GET articles/1.xml
      def show
        respond_to do |format|
          format.json { render json: @article }
          format.xml { render xml: @article }
        end
      end

      # POST /blog/:blog_id/articles
      # POST /blog/:blog_id/articles.xml
      def create
        @article = Article.new(article_params)

        respond_to do |format|
          if @article.save
            format.json { render json: @article }
            format.xml { render xml: @article }
          else
            format.json { render json: @article.errors, status: :unprocessable_entity }
            format.xml { render xml: @article.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT articles/1
      # PATCH/PUT articles/1.xml
      def update
        respond_to do |format|
          if @article.update(article_params)
            format.json { render json: @article, status: :ok }
            format.xml { render xml: @article, status: :ok }
          else
            format.json { render json: @article.errors, status: :unprocessable_entity }
            format.xml { render xml: @article.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE articles/1
      # DELETE articles/1.xml
      def destroy
        @article.destroy
        respond_to do |format|
          format.json { head :no_content }
          format.xml { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_article
        @article = Article.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def article_params
        params.permit(:title, :content, :blog_id)
      end
    end
  end
end