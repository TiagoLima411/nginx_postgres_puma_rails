class BankTransactionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bank_transaction = BankTransaction.new
    origin = @bank_transaction.class.name.downcase
    if is_defined_param?(:cpf) && is_defined_param?(:payment_password)
      if valid_payment_user(origin, params[:cpf], params[:payment_password])
        @payment_password = true
        respond_to do |format|
          format.html { render :new } 
        end
      else
        valid_payment_user(origin, nil, nil)
      end
    else
      valid_payment_user(origin, nil, nil)
    end

  end

  def create
    @bank_transaction = BankTransaction.new(bank_transaction_params)

    respond_to do |format|
      if @bank_transaction.save
        format.html { redirect_to dashboard_path, notice: 'Transferência efetuada com sucesso.' }
        format.json { render :show, status: :created, location: @bank_transaction }
      else
        format.html { render :new }
        format.json { render json: @bank_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
  # Never trust parameters from the scary internet, only allow the white list through.
  def bank_transaction_params
    params.require(:bank_transaction).permit(:id, :user_id, :benefited_user_id, :net_value, :description)
  end

end
