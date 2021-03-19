class JsonWebToken
  extend ActiveSupport::Concern    
    HMAC_SECRET = Rails.application.credentials.secret_key_base

    def self.encode(payload, exp = 30.years.from_now)      
      payload[:exp] = exp.to_i
      JWT.encode(payload, HMAC_SECRET)
    end        

    def self.decode(token)
      body = JWT.decode(token, HMAC_SECRET)[0]
      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature, JWT::VerificationError => e
      raise ExceptionHandler::ExpiredSignature, e.message
    rescue JWT::DecodeError, JWT::VerificationError => e
      raise ExceptionHandler::DecodeError, e.message
    end
end