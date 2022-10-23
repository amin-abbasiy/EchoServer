class Api::V1::BaseController < ApplicationController
  include ::Authenticable
  attr_reader :current_user

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    # we can not use application controller case for jwt case
    # because user not found default is not_found code but for
    # user case we must respond unauthorized
    begin
      @decoded = ::Authenticable::JWT.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ::ActiveRecord::RecordNotFound => e
      render json: { errors: [
        "title":  I18n.t("error_messages.unauthorized.title"),
        "status": 401,
        "code": I18n.t("error_messages.unauthorized.code"),
        "message": [
          e.message
        ]
      ]}, status: 401
      # decode error are handling in application controller
    end
  end
end
