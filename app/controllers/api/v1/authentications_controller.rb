module Api
  module V1
    class AuthenticationsController < ApplicationController
      def login
        service = ::Authentication::SignIn.new(login_params)
        result = service.call

        render json: result
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
