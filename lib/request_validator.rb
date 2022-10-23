class RequestValidator
  URI_VALIDATOR_REGEX = ::Regexp.new(/[a-z0-9]/).freeze
  def initialize(app)
    @app = app
  end

  def call(env)
    request_url = Rack::Request.new(env).url
    validation = URI_VALIDATOR_REGEX.match?(request_url)

    raise URI::InvalidURIError, "Request contains invalid charachters!" unless validation

    rescue URI::InvalidURIError => e
      [400, {'Content-type' => 'text/html'}, [{ error: e.message }.to_json]]

  end
end