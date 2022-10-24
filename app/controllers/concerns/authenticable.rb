module Authenticable
  module JWT
    SECRET_KEY = "1796cd4ee4df6aa059ce969de7976a7c9a51b226603b0f97569c18251d942fed509c3643da7cf601aa8a88e14f11b689b2ae5b4b9aea7836b4ef93fc8836318e"
      # Rails.application.secrets.secret_key_base.to_s

    def self.encode(payload,
                    exp = ENV.fetch("JWT_EXP", 24.hours.from_now))

      payload[:exp] = exp.to_i
      ::JWT.encode(payload, SECRET_KEY)
    end

    def self.decode(token)
      decoded = ::JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new decoded
    end
  end
end