module Api
  module V1
    class ApplicationController < ActionController::API
      def is_valid_user
        unless params[:token].nil?
          user = User.authenticate_token(params[:token])
          if user
            @user = user
          else
            respond_to do |format|
              format.json { render json: {error: 'Not Authorized'}, status: 401 }
              format.xml { render xml: {error: 'Not Authorized' }, status: 401 }
            end
          end
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

