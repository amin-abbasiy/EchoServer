class Endpoint::Mock
  def initialize(callback)
    @callback = callback
  end

  def call
    @response = endpoint.body
    @response = ::JSON.parse(@response)

    #if object is not valid json we return raw data user created before
    rescue JSON::ParserError
      return @response

    @response
  end

  private
  def endpoint
    @callback.current_user.endpoints.find_by!(verb: @callback.request.request_method,
                                              path: @callback.request.path)
  end
end