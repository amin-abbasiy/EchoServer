class EchoError < StandardError
  attr_reader :status, :code
  def initialize(code, parameters = {})
    @code = code
    @status = 200
  end

  def message
    case @code
    when :data_validation
      @status = 400
      renderer(code)
    when :attribute_validation
      @status = 400
      renderer(code)
    when :response_validation
      @status = 400
      renderer(code)
    when :jwt_decode_error
      renderer(code)
    else
      @status = 400
      return I18n.t("error_messages.echo_error.unknown")
    end
  end

  def renderer(code)
    return I18n.t("error_messages.echo_error.#{@code}")
  end
end