require 'rails_helper'


RSpec.describe 'Pagseguro API', type: :request do
  describe 'Sandbox Pagseguro integration billet' do
    before(:context) do
      @url_base_ws      = 'https://ws.sandbox.pagseguro.uol.com.br'
      @token            = Rails.application.credentials[Rails.env.to_sym][:pagseguro_token]
      @email            = Rails.application.credentials[Rails.env.to_sym][:email]

      @session          = create_session
      @payment_methods  = get_payment_methods(@session['session']['id'])
      @transaction      = send_billet_transaction
    end

    context 'session' do
      it 'responds with session id present' do
        expect(@session['session']['id'].present?).to eq(true)
      end
    end

    context 'payment methods' do
      it 'check payment method error false' do
        expect(@payment_methods['error']).to eq(false)
      end
      it 'check payment method boleto true' do
        expect(@payment_methods['paymentMethods']['BOLETO'].present?).to eq(true)
      end
      it 'check payment method balance true' do
        expect(@payment_methods['paymentMethods']['BALANCE'].present?).to eq(true)
      end
      it 'check payment method online_debit true' do
        expect(@payment_methods['paymentMethods']['ONLINE_DEBIT'].present?).to eq(true)
      end
      it 'check payment method credit_card true' do
        expect(@payment_methods['paymentMethods']['CREDIT_CARD'].present?).to eq(true)
      end
      it 'check payment method deposit true' do
        expect(@payment_methods['paymentMethods']['DEPOSIT'].present?).to eq(true)
      end
    end

    context 'billet_transaction' do
      it 'check billet_transaction' do
        expect(@transaction.present?).to eq(true)
        expect(@transaction['transaction'].present?).to eq(true)

        # General information
        expect(@transaction['transaction']['date'].present?).to eq(true)
        expect(@transaction['transaction']['code'].present?).to eq(true)
        expect(@transaction['transaction']['type'].present?).to eq(true)
        expect(@transaction['transaction']['status'].present?).to eq(true)
        expect(@transaction['transaction']['lastEventDate'].present?).to eq(true)
        expect(@transaction['transaction']['paymentMethod'].present?).to eq(true)
        expect(@transaction['transaction']['grossAmount'].present?).to eq(true)
        expect(@transaction['transaction']['discountAmount'].present?).to eq(true)

        # Fees
        expect(@transaction['transaction']['creditorFees']['intermediationRateAmount'].present?).to eq(true)
        expect(@transaction['transaction']['creditorFees']['intermediationFeeAmount'].present?).to eq(true)
        expect(@transaction['transaction']['netAmount'].present?).to eq(true)
        expect(@transaction['transaction']['extraAmount'].present?).to eq(true)

        # Items and installments
        expect(@transaction['transaction']['installmentCount'].present?).to eq(true)
        expect(@transaction['transaction']['itemCount'].present?).to eq(true)
        expect(@transaction['transaction']['items'].present?).to eq(true)

        # Sender information
        expect(@transaction['transaction']['sender'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['name'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['email'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['phone'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['phone']['areaCode'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['phone']['number'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['documents'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['documents']['document'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['documents']['document']['type'].present?).to eq(true)
        expect(@transaction['transaction']['sender']['documents']['document']['value'].present?).to eq(true)

        # Shipping information
        expect(@transaction['transaction']['shipping'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['street'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['number'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['district'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['city'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['state'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['country'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['address']['postalCode'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['type'].present?).to eq(true)
        expect(@transaction['transaction']['shipping']['cost'].present?).to eq(true)

        # PublicKey
        expect(@transaction['transaction']['primaryReceiver']['publicKey'].present?).to eq(true)
      end
    end

    private

    # First step create a session
    def create_session
      app_id = Rails.application.credentials[Rails.env.to_sym][:app_id]
      app_key = Rails.application.credentials[Rails.env.to_sym][:app_key]
      headers = { 'Accept': 'application/vnd.pagseguro.com.br.v3+xml', 'Content-Type': 'application/x-www-form-urlencoded'}
      VCR.use_cassette('pagseguro_billet/billet_session') do
        response = HTTParty.post("#{@url_base_ws}/sessions?appId=#{app_id}&appKey=#{app_key}", headers: headers)
        Hash.from_xml(response.parsed_response.gsub("\n", ''))
      end
    end

    # Second step Get Payments Methods
    def get_payment_methods(session_id)
      headers = { 'Accept': 'application/vnd.pagseguro.com.br.v1+json;charset=ISO-8859-1' }
      VCR.use_cassette('pagseguro_billet/payment_methods') do
        response = HTTParty.get("#{@url_base_ws}/payment-methods?amount=10.00&sessionId=#{session_id}", headers: headers)
        JSON.parse(response)
      end
    end

    # Sixth step generate transaction
    def send_billet_transaction
      headers = { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' }
      body = body_billet_mock
      VCR.use_cassette('pagseguro_billet/transaction') do
        response = HTTParty.post("#{@url_base_ws}/transactions/", body: body, headers: headers)
        Hash.from_xml(response.body)
      end
    end

    def body_billet_mock
      {
        'email': @email,
        'token': @token,

        'payment.mode': 'default',
        'payment.method': 'boleto',
        'currency': 'BRL',

        'item[1].id': '1',
        'item[1].description': 'Recargar em conta',
        'item[1].amount': '11.00',
        'item[1].quantity': '1',

        'notificationURL': 'http://localhost:3000/pagseguro/notify',
        'reference': 'ORDER123',

        'sender.name': 'Tiago de Lima Alves',
        'sender.CPF': '16261677026',
        'sender.areaCode': '82',
        'sender.phone': '999999999',
        'sender.email': 'tiago@sandbox.pagseguro.com.br',

        'shipping.address.street': 'Conj. Celly Loureiro, Qd - E',
        'shipping.address.number': '71',
        'shipping.address.complement': '5o andar',
        'shipping.address.district': 'Benedito Bentes',
        'shipping.address.postalCode': '57084-000',
        'shipping.address.city': 'Macei??',
        'shipping.address.state': 'AL',
        'shipping.address.country': 'BRA',

        'shipping.type': '3',
        'shipping.cost': '0.00'
      }
    end
    
  end
end
