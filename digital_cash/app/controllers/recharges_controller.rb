class RechargesController < ApplicationController
  before_action :set_recharge, only: %i[send_card_transaction]

  def send_card_transaction
  	response = Pagseguro::Operation.send_card_transaction(@card_info, current_user)
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
    @recharge = Recharge.new
  end

  private

  def set_recharge
    value = params[:amount].gsub(',','.')
    @card_info = {
      'amount': value,
      'cardNumber': params[:card_number],
      'cardCvv': params[:card_cvv],
      'cardExpirationMonth': params[:card_expiration_month],
      'cardExpirationYear': params[:card_expiration_year]
    }
  end
end
