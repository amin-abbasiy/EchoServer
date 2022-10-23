module Api
  module V1
    class EndpointsController < BaseController
      before_action :authorize_request
      def index
        @endpoints = current_user.endpoints

        render json: @endpoints, status: 200
      end
      def show
        render json: { message: "Hello" }
      end

        def create
          service = ::Endpoint::Create::new(permitted_params, self)
          result = service.call

          render json: result, status: 201
        end

        def delete
        end

        def update
        end

      private
      def permitted_params
        params.permit!.slice(:data)[:data]
      end
    end
  end
end
