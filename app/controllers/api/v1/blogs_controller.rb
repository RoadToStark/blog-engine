module Api
  module V1
    class BlogsController < ApplicationController

      include ActionController::MimeResponds
      before_action :set_blog, only: [:update, :destroy, :show]
      before_action :is_valid_user, only: [:update, :destroy, :create ]

      # GET /blogs
      # GET /blogs.xml
      def index
        @blogs = Blog.all

        respond_to do |format|
          format.json { render json: @blogs}
          format.xml { render xml: @blogs}
        end
      end

      # GET /blogs/1
      # GET /blogs/1.xml
      def show
        respond_to do |format|
          format.json { render json: @blog }
          format.xml { render xml: @blog }
        end
      end

      # POST /blogs
      # POST /blogs.xml
      def create
        @blog = Blog.new(blog_params)
        @blog.users << @user

        respond_to do |format|
          if @blog.save
            format.json { render json: @blog }
            format.xml { render xml: @blog }
          else
            format.json { render json: @blog.errors, status: :unprocessable_entity }
            format.xml { render xml: @blog.errors, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /blogs/1
      # PATCH/PUT /blogs/1.xml
      def update
        respond_to do |format|
          if @blog.update(blog_params)
            format.json { render json: @blog, status: :ok }
            format.xml { render xml: @blog, status: :ok }
          else
            format.json { render json: @blog.errors, status: :unprocessable_entity }
            format.xml { render xml: @blog.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /blogs/1
      # DELETE /blogs/1.xml
      def destroy
        @blog.destroy
        respond_to do |format|
          format.json { head :no_content }
          format.xml { head :no_content }
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_blog
        @blog = Blog.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def blog_params
        params.permit(:title, :description, :cover)
      end
    end
  end
end