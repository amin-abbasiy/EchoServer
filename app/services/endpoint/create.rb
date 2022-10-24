class Endpoint::Create
  def initialize(data, callback)
    @callback = callback

    @data, @attributes, @response = ::Endpoint::ChopData.new(data).call
    ::Endpoint::Validate.new(@data, @attributes, @response).call
  end

  def call
    response = { headers: @response[:headers], body: @response[:body] }
    endpoint = @callback.current_user.endpoints.create(verb: @attributes[:verb],
                                                       path: @attributes[:path],
                                                       code: @response[:code],
                                                       headers: @response[:headers],
                                                       body: @response[:body],
                                                       response: response)

    endpoint
  end

  private

  attr_reader :callback
              :endpoint
end