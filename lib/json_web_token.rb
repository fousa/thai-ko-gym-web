class JsonWebToken
  class << self
    def encode(payload, expires_in = 24.hours.from_now)
      payload[:exp] = expires_in.to_i
      JWT.encode payload, Rails.application.secrets.secret_key_base
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base).first
      HashWithIndifferentAccess.new body
    end
  end
end
