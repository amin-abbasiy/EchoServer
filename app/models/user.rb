class User < ApplicationRecord
  has_secure_password

  has_many :auth_tokens

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }
end
