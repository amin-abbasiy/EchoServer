class Endpoint::ChopData
  def initialize(data)
    @data = data
  end

  def call
    raise ::EchoError.new(:response_validation) if @data.blank?

    keys = @data&.slice(:type, :attributes)
    type, attributes = keys[:type], keys[:attributes]
    response = attributes&.slice(:response).try(:[], :response)

    [@data, attributes, response]
  end
end
