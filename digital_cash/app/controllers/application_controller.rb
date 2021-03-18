class ApplicationController < ActionController::Base
  include Pundit

  include ExceptionLogger::ExceptionLoggable # loades the module
  unless Rails.env.development?
    rescue_from Exception do |e|
      handle_exception(e)
    end
  end

  protect_from_forgery with: :null_session

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!
  before_action :prepare_exception_notifier

  include Response

  #def authorize_request
  #  if request.format == "application/json"
  #    if request.headers['Authorization'].present?
  #      auth = request.headers['Authorization']
  #      if auth.eql?(Rails.application.credentials.orakulo_auth_token)
  #        @user ||= User.find(908)
  #      else
  #        authenticate_user!
  #      end
  #    else
  #      authenticate_user!
  #    end
  #  else
  #    authenticate_user!
  #  end
  #end

  def after_sign_in_path_for(_resource)
    '/dashboard'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def not_active_user
    '/users/sign_in'
  end

  def is_defined_param?(param)
    !params[param].nil? && !params[param].empty?
  end

  protected

  def verify_root_access!
    unless current_user.root?
      redirect_to '/dashboard', notice: 'Você não tem permissão para executar esta ação.'
    end
  end

  def check_credentials_outgoing(cpf = nil, payment_password = nil)
    redirect_to "/outgoings/new?cpf=#{cpf}&payment_password=#{payment_password}"
  end

  def check_credentials_bank_transaction(cpf = nil, payment_password = nil)
    redirect_to "/bank_transactions/new?cpf=#{cpf}&payment_password=#{payment_password}"
  end

  def valid_payment_user(origin, cpf = nil, payment_password = nil)
    if cpf.nil? && payment_password.nil?
      @payment_password = false
      if origin.eql?('outgoing')
        redirect_to outgoing_payment_password_path, notice: 'Insira sua senha de pagamento.'
      elsif origin.eql?('banktransaction')
        redirect_to bank_transaction_payment_password_path, notice: 'Insira sua senha de pagamento.'
      else
        redirect_to dashboard_path, notice: 'Insira sua senha de pagamento.'
      end
    else
      payment = User.valid_payment_password?(cpf, payment_password)
      
      if !payment.nil?
        return true
      else
        @payment_password = false
        return false
      end 
    end
  end

  def json_pagination(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end

  def handle_exception(e)
    #Future integrations
    #Thread.new do
    #  slack = Slack::Notifier.new 'https://hooks.slack.com/services/' do
    #    defaults channel: '#dc-logs',
    #             username: 'digital_cash',
    #             icon_emoji: ':robot_face:'
    #  end
    #  slack.ping("ERROR: #{e.message}\n#{e.backtrace}")
    #end
    log_exception_handler(e)
    #Sentry.capture_exception(e)
  end

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :USUARIO => current_user.inspect,
      :PARAMS => request.params.inspect
    }
  end

  def user_not_authorized
    flash[:notice] = 'Você não tem permissão para executar esta ação'
    redirect_to(request.referrer || '/dashboard')
  end
end
