module Authenticable
  module JWT
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s.freeze
    ALG = ENV.fetch('JWT_ALG', 'HS256').freeze
    def self.encode(payload,
                    exp = ENV.fetch("JWT_EXP", 24.hours.from_now))
      payload.merge!(exp: exp.to_i, iss: 'user',
                     sub: 'echo_user', aud: 'echo_system',
                     iat: Time.now.to_i)
      ::JWT.encode(payload, SECRET_KEY, ALG)
    end

    def self.decode(token)
      decoded = ::JWT.decode(token, SECRET_KEY, { algorithm: ALG })[0]
      ::HashWithIndifferentAccess.new decoded
    end
  end
end