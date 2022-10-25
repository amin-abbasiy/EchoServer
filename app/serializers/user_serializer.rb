class UserSerializer < ActiveModel::Serializer
  type 'users'

  attributes :id, :username, :email, :authentication

  def authentication
    { jwt: auth_token.value, exp: auth_token.expire_at }
  end

  def auth_token
    object.auth_tokens.last
  end
end