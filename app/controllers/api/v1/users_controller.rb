module Api
  module V1
    class UsersController < ApplicationController

      include ActionController::MimeResponds

      # POST /users
      # POST /users.xml
      def create
        @user = User.new(user_params)

        respond_to do |format|
          if @user.save
            format.json { render json: @user }
            format.xml { render xml: @user }
          else
            format.json { render json: @user.errors, status: :unprocessable_entity }
            format.xml { render xml: @user.errors, status: :unprocessable_entity }
          end
        end
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def user_params
        params.permit(:username, :email, :password)
      end

    end
  end
end