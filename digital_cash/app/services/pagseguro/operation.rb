module Pagseguro
  class Operation

    APP_ID  = Rails.application.credentials[Rails.env.to_sym][:app_id]
    APP_KEY = Rails.application.credentials[Rails.env.to_sym][:app_key]
    TOKEN   = Rails.application.credentials[Rails.env.to_sym][:pag_seguro_test_token]
    EMAIL   = Rails.application.credentials[Rails.env.to_sym][:email]
    BASE_WS = 'https://ws.sandbox.pagseguro.uol.com.br'.freeze
    BASE_HELPERS = 'https://df.uol.com.br'.freeze

    def self.send_card_transaction(card_params, logged_user)
      session_id = session
      card_token = card_token(card_params, session_id)
      return { error: { msg: 'Erro na transação tente novamente!' } } if session_id.nil? || card_token.nil?
      
      headers = { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' }
      body = body_transaction(logged_user, card_token, card_params[:amount])
      response = HTTParty.post("#{BASE_WS}/transactions/", body: body, headers: headers)

      if response.code.eql?(200)
        Recharge.generate_credit_cad(Hash.from_xml(response.body), logged_user)
      else
        { error: { msg: 'Erro na transação tente novamente!' } }
      end

    end

    private

    def self.card_token(card_params, session_id)
      card = card_brand(card_params[:cardNumber][0..5], session_id)
      return { error: { msg: 'Erro na transação tente novamente!' } } unless card['bin'].present?

      card_params[:sessionId] = session_id
      card_params[:cardBrand] = card['bin']['brand']['name']

      headers = { 'Content-Type': 'application/x-www-form-urlencoded', 'Accept': 'application/json' }
      response = HTTParty.post("#{BASE_HELPERS}/v2/cards", body: card_params, headers: headers)
      return unless response.headers['content-type'] == 'application/json'

      parsed_hash = JSON.parse(response.body)
      return unless response.code.eql?(200) && parsed_hash.key?('token')

      @card_token = parsed_hash['token']
    end

    def self.card_brand(card_digits, session_id)
      response = HTTParty.get("#{BASE_HELPERS}/df-fe/mvc/creditcard/v1/getBin?tk=#{session_id}&creditCard=#{card_digits}")
      return unless response.code.eql?(200)

      JSON.parse(response.body)
    end

    def self.session
      headers = { 'Accept': 'application/vnd.pagseguro.com.br.v3+xml', 'Content-Type': 'application/x-www-form-urlencoded'}
      response = HTTParty.post("#{BASE_WS}/sessions?appId=#{APP_ID}&appKey=#{APP_KEY}", headers: headers)
      return unless response.code.eql?(200)

      hash = Hash.from_xml(response.body.gsub("\n", ''))
      hash['session']['id']
    end

    def self.body_transaction(user, card_token, value)
      phone = user&.member&.phone&.split(')')
      area_code = phone[0].gsub(/[^0-9]/, '')
      phone_number = phone[1].gsub(/[^0-9]/, '')
      cpf = user&.member&.cpf&.gsub(/[^0-9]/, '')
      {
        'email': EMAIL,
        'token': TOKEN,

        'item[1].id': '1',
        'item[1].description': 'Recargar em conta',
        'item[1].amount': value,
        'item[1].quantity': '1',

        'payment.mode': 'default',
        'payment.method': 'creditCard',

        'currency': 'BRL',

        'sender.name': user&.member&.name,
        'sender.CPF': cpf,
        'sender.areaCode': area_code,
        'sender.phone': phone_number,
        'sender.email': user&.member&.email,

        'shipping.address.street': user&.member&.address,
        'shipping.address.number': user&.member&.address_number,
        'shipping.address.district': user&.member&.district,
        'shipping.address.postalCode': user&.member&.zipcode,
        'shipping.address.city': user&.member&.city&.name,
        'shipping.address.state': user&.member&.state&.uf,
        'shipping.address.country': 'BRA',

        'installment.quantity': '1',
        'installment.value': value,
        'installment.noInterestInstallmentQuantity': '2',

        'creditCard.token': card_token,
        'creditCard.holder.name': user&.member&.name,
        'creditCard.holder.CPF': cpf,
        'creditCard.holder.birthDate': user&.member&.birthday&.strftime('%d/%m/%Y'),
        'creditCard.holder.areaCode': area_code,
        'creditCard.holder.phone': phone_number,

        'billingAddress.street': user&.member&.address,
        'billingAddress.number': user&.member&.address_number,
        'billingAddress.district': user&.member&.district,
        'billingAddress.postalCode': user&.member&.zipcode,
        'billingAddress.city': user&.member&.city&.name,
        'billingAddress.state': user&.member&.state&.uf,
        'billingAddress.country': 'BRA',

        'notificationURL': 'http://localhost:3000/pagseguro/notify'
      }
    end
  end
end