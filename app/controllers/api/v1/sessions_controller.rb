module Api
  module V1
    class SessionsController < ApplicationController

      include ActionController::MimeResponds
      before_action :is_valid_user, only: [:destroy]

      def create
        @user = User.authenticate(params[:email], params[:password])

        if @user
          @user.auth_token = SecureRandom.hex
          respond_to do |format|
            if @user.save
              format.json { render json: @user.auth_token }
              format.xml { render xml: @user.auth_token }
            else
              format.json { render json: @user.errors, status: :unprocessable_entity }
              format.xml { render xml: @user.errors, status: :unprocessable_entity }
            end
          end
        else
          respond_to do |format|
            format.json { render json: {error: 'Not Authorized'}, status: 401 }
            format.xml { render xml: {error: 'Not Authorized' }, status: 401 }
          end
        end
      end

      def destroy
        @user.auth_token = nil
        if @user.save
          respond_to do |format|
            format.json { render json: 'Success' }
            format.xml { render xml: 'Success' }
          end
        else
          respond_to do |format|
            format.json { render json: @user.errors, status: :unprocessable_entity }
            format.xml { render xml: @user.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
end
