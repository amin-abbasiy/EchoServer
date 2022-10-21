class AuthToken < ApplicationRecord
  belongs_to :user

  enum token_type: { login: 0, encryption: 1}
end
