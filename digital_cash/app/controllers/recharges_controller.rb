class RechargesController < ApplicationController
  before_action :authenticate_user!, except: %i[notify]
  before_action :set_recharge, only: %i[send_card_transaction]

  def send_card_transaction
  	response = Pagseguro::Operation.send_card_transaction(@card_info, current_user, @session_id, @sender_hash)
  	respond_to do |format|
  	  if response.instance_of? Recharge
  	  	flash[:success] = 'Recarga criada com sucesso.'
  	  	format.html { redirect_to account_extracts_path }
  	  else
  	  	flash[:error] = response[:error][:msg]
  	  	format.html { redirect_to new_recharge_path }
  	  end
  	end
  end

  def new
    @session_id = Pagseguro::Operation.session
    @recharge = Recharge.new
  end

  def notify
    render json: {msg: "OK"}
  end

  private

  def set_recharge
    value = params[:amount].gsub(',', '.')
    @session_id = params[:session_id]
    @sender_hash = params[:s_hash]
    @card_info = {
      'amount': value,
      'cardNumber': params[:card_number],
      'cardCvv': params[:card_cvv],
      'cardExpirationMonth': params[:card_expiration_month],
      'cardExpirationYear': params[:card_expiration_year]
    }
  end
end
