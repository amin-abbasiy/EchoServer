class ApplicationController < ActionController::API
  VALID_STATUS_CODES = %W(200 201 204)

  rescue_from ActiveRecord::RecordNotFound do |e|
    message = %Q{#{e.model} } + I18n.t("error_messages.record_not_found.message")
    render_json_error(:not_found, :record_not_found, nil,  message: [message])
  end

  rescue_from ::JWT::DecodeError do |e|
    render_json_error(:unauthorized, :user_is_unauthorized, nil,  message: [e])
  end

  rescue_from ::ActiveRecord::RecordNotUnique do |exception|
    errors_messages = [exception.message.sub(/ \[[^\]]*\]/, '')]
    render_json_error(:conflict, :record_not_uniq, nil, message: errors_messages)
  end

  rescue_from ::ActiveRecord::RecordInvalid do |exception|
    errors_messages = [exception.message.sub(/ \[[^\]]*\]/, '')]
    render_json_error(:bad_request, :record_invalid, nil, message: errors_messages)
  end

  rescue_from ::ArgumentError do |_exception|
    errors_messages = [_exception.message]
    render_json_error(:bad_request, :argument_error, nil, message: errors_messages)
  end

  rescue_from ::ActionDispatch::Http::Parameters::ParseError do |exception|
    errors_messages = [exception.message]
    render_json_error(:bad_request, :parameter_error, nil, message: errors_messages)
  end

  rescue_from ::EchoError do |_exception|
    errors_messages = [_exception.message]
    render_json_error(_exception.status, :echo_error, _exception.code, message: errors_messages)
  end


  def render_json_error(status, error_class, code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      title: I18n.t("error_messages.#{error_class}.title"),
      status: status,
      code: I18n.t("error_messages.#{error_class}.#{code || 'code'}")
    }.merge(extra)

    detail = I18n.t("error_messages.#{error_class}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { errors: [error] }, status: status
  end
end
