class BanksController < ApplicationController
    acts_as_token_authentication_handler_for User, except: [:bank, :insert_banks]

    skip_before_action :verify_authenticity_token  

    def list_banks
        banks = Bank.all
        render json: banks, status: :ok 
    end

    def bank
        if params[:code].present?
            bank = Bank.find_by(code: params[:code])
            render json: bank, status: :ok
        else
            message = "Informe o código do banco"
            render json: message, status: :not_found
        end
    end

end
