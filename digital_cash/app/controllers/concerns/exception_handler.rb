module ExceptionHandler
  extend ActiveSupport::Concern
  include ActiveSupport::Rescuable
  include Response

  class DecodeError < StandardError; end
  class ExpiredSignature < StandardError; end
  class AuthenticationError < StandardError; end

  included do
    rescue_from ExceptionHandler::DecodeError do |e|
      json_response({ message: e.message }, :unauthorized)
    end
    rescue_from ExceptionHandler::ExpiredSignature do |e|
      json_response({ message: e.message }, :unauthorized)
    end
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
  end

  private

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
