class EndpointSerializer < ActiveModel::Serializer
  type 'endpoints'

  attributes :verb, :path, :response

  def response
    { code: object.code, headers: object.headers, body: object.body }
  end
end