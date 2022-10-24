module Api
  module V1
    class EndpointsController < BaseController
      before_action :authorize_request
      before_action :find_endpoint, only: %w(update delete)
      def index
        @endpoints = current_user.endpoints

        render json: @endpoints, status: 200
      end
      def create
        service = ::Endpoint::Create::new(permitted_params, self)
        result = service.call

        render json: result, status: 201
      end
      def update
        service = ::Endpoint::Update::new(permitted_params, @endpoint)
        result = service.call

        render json: result, status: 200
      end

      def delete
      end

      def show
        render json: { message: "Hello" }
      end

      private
      def permitted_params
        params.permit!.slice(:data)[:data]
      end

      def find_endpoint
        @endpoint = current_user.endpoints.find(params[:id])
      end
    end
  end
end
