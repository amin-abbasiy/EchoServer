class Endpoint::Create
  REQUIRED_ATTRIBUTE_KEYS = %w(verb path response).freeze
  REQUIRED_DATA_KEYS = %w(type attributes).freeze
  REQUIRED_RESPONSE_KEYS = %w(code headers body).freeze
  def initialize(data, callback)
    @data = data
    @callback = callback
    chop_data
    validate_data
  end

  def call
    response = { headers: @response[:headers], body: @response[:body] }
    endpoint = @callback.current_user.endpoints.create(verb: @attributes[:verb],
                                                       path: @attributes[:path],
                                                       endpoint_type: @type,
                                                       code: @response[:code],
                                                       headers: @response[:headers],
                                                       body: @response[:body],
                                                       response: response)

    endpoint
  end

  private
  def chop_data
    raise ::EchoError.new(:response_validation) if @data.blank?

    keys = @data&.slice(:type, :attributes)
    @type, @attributes = keys[:type], keys[:attributes]
    @response = @attributes&.slice(:response).try(:[], :response)
  end
  def validate_data
    raise ::EchoError.new(:data_validation) unless @data&.keys&.all? { |data| REQUIRED_DATA_KEYS&.include?(data) }
    raise ::EchoError.new(:attribute_validation) unless @attributes&.keys&.all? { |data| REQUIRED_ATTRIBUTE_KEYS.include?(data) }
    raise ::EchoError.new(:response_validation) unless @response&.keys&.all? { |data| REQUIRED_RESPONSE_KEYS&.include?(data) }
  end

  attr_reader :data
              :callback
              :endpoint
end