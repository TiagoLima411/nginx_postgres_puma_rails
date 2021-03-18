class ApiController < ApplicationController
  include ExceptionHandler

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  skip_before_action :authenticate_user!
  before_action :authorize_request

  def authorize_request
    if request.format == "application/json"
      if request.headers['Authorization'].present?
        auth = request.headers['Authorization']
        decoded_auth_token = JsonWebToken.decode(auth)
        token = decoded_auth_token
        @user ||= User.find(token["user_id"].to_i)
      else
        authenticate_user!
      end
    else
      authenticate_user!
    end
  end

  def error_responses(obj_err)
    arr_err = []
    erro = {}
    obj_err.full_messages.each do |msg|
      erro = {err: msg}
      arr_err.push(erro)
    end
    arr_err
  end

  private

  def user_not_authorized
    json_response(Message.unauthorized, :not_authorized)
  end

  end
