class User < ApplicationRecord
  has_secure_password

  has_many :auth_tokens, dependent: :destroy
  has_many :endpoints, dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 8 },
            if: -> { new_record? || !password.nil? }

  def token
    ::Authenticable::JWT::encode({ user_id: self.id })
  end
end
