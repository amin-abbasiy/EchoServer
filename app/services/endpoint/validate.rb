class Endpoint::Validate
  REQUIRED_ATTRIBUTE_KEYS = %w(verb path response).freeze
  REQUIRED_DATA_KEYS = %w(type attributes id).freeze
  REQUIRED_RESPONSE_KEYS = %w(code headers body).freeze

  def initialize(data, attributes, response)
    @data = data
    @attributes = attributes
    @response = response
  end

  def call
    raise ::EchoError.new(:data_validation) unless @data&.keys&.all? { |data| REQUIRED_DATA_KEYS&.include?(data) }
    raise ::EchoError.new(:attribute_validation) unless @attributes&.keys&.all? { |data| REQUIRED_ATTRIBUTE_KEYS.include?(data) }
    raise ::EchoError.new(:response_validation) unless @response&.keys&.all? { |data| REQUIRED_RESPONSE_KEYS&.include?(data) }
  end
end