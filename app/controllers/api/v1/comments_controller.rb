module Api
  module V1
    class CommentsController < ApplicationController

      include ActionController::MimeResponds
      before_action :set_comment, only: [:update, :destroy, :show]
      before_action :is_valid_user, only: [:update, :destroy, :create ]

      # GET /articles/:article_id/comments or GET /comments
      # GET /articles/:article_id/comments.xml or GET /comments.xml
      def index
        params[:article_id].present? ? @comments = Article.find(params[:article_id]).comments : @comments = Comment.all

        respond_to do |format|
          format.json { render json: @comments }
          format.xml { render xml: @comments }
        end
      end

      # GET comments/1
      # GET comments/1.xml
      def show
        respond_to do |format|
          format.json { render json: @comment }
          format.xml { render xml: @comment }
        end
      end

      # POST /articles/:article_id/comments
      # POST /articles/:article_id/comments.xml
      def create
        @comment = Comment.new(comment_params)
        @comment.user_id = @user.id
        respond_to do |format|
          if @comment.save
            format.json { render json: @comment }
            format.xml { render xml: @comment }
          else
            format.json { render json: @comment.errors, status: :unprocessable_entity }
            format.xml { render xml: @comment.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT comments/1
      # PATCH/PUT comments/1.xml
      def update
        respond_to do |format|
          if @comment.update(comment_params)
            format.json { render json: @comment, status: :ok }
            format.xml { render xml: @comment, status: :ok }
          else
            format.json { render json: @comment.errors, status: :unprocessable_entity }
            format.xml { render xml: @comment.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE comments/1
      # DELETE comments/1.xml
      def destroy
        @comment.destroy
        respond_to do |format|
          format.json { head :no_content }
          format.xml { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def comment_params
        params.permit(:title, :content, :article_id)
      end
    end
  end
end