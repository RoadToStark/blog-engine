module Api
  module V1
    class ArticlesController < ApplicationController

      include ActionController::MimeResponds
      before_action :set_article, only: [:update, :destroy, :show]
      before_action :is_valid_user, only: [:update, :destroy, :create]
      before_action :is_post_author, only: [:update, :destroy]

      # GET /blog/:blog_id/articles or GET /users/:user_id/articles or GET /articles
      # GET /blog/:blog_id/articles.xml or GET /users/:user_id/articles.xml or GET /articles.xml
      def index
        if params[:blog_id].present?
          @articles = Blog.find(params[:blog_id]).articles
        elsif params[:user_id].present?
          @articles = User.find(params[:user_id]).articles
        else
          @articles = Article.all
        end

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
        @article.user_id = @user.id
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

      # Enable only post author
      def is_post_author
        if @user.id == @article.user_id
          true
        else
          respond_to do |format|
            format.json { render json: {error: 'Not Authorized'}, status: 401 }
            format.xml { render xml: {error: 'Not Authorized' }, status: 401 }
          end
        end
      end
    end
  end
end