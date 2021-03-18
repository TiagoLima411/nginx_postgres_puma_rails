class SessionPaymentsController < ApplicationController
  before_action :authenticate_user!

  def middleware_outgoing_payment_password
    if is_defined_param?(:cpf) && is_defined_param?(:payment_password)
      check_credentials_outgoing(params[:cpf], params[:payment_password])
    end
  end

  def middleware_bank_transaction_payment_password
    if is_defined_param?(:cpf) && is_defined_param?(:payment_password)
      check_credentials_bank_transaction(params[:cpf], params[:payment_password])
    end
  end

end
