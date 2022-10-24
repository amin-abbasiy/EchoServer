class Endpoint::Update
  def initialize(data, endpoint)
    @endpoint = endpoint

    @data, @attributes, @response = ::Endpoint::ChopData.new(data).call
    ::Endpoint::Validate.new(@data, @attributes, @response).call
  end

  def call
    response = { headers: @response[:headers], body: @response[:body] }
    @endpoint.update(verb: @attributes[:verb],
                       path: @attributes[:path],
                       code: @response[:code],
                       headers: @response[:headers],
                       body: @response[:body],
                       response: response)

    @endpoint.reload
  end

  private

  attr_reader :endpoint
end