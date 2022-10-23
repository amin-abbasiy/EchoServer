class Api::V1::BaseController < ApplicationController
  include ::Authenticable
  attr_reader :current_user

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = ::Authenticable::JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ::ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
      # decode error are handling in application controller
    end
  end
end
