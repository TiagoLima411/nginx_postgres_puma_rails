module Coingecko
  class Operation

    def self.coins_list
      Request.get('coins/list')
    end

    def self.vs_currency_list
      Request.get('simple/supported_vs_currencies')
    end

    def self.send_card_info(info_operation, store, user, transaction_params, ip_request)
      body = info_operation.to_json
      res, status = Request.post('adiq/transaction', body)
      data = JSON.parse(res.to_json)
      response = Hashit.new(data)
      if [200, 202, 201].include?(status)
        store_transaction = StoreTransaction.generate_type_credit_donate(response.transaction, info_operation, store, user, transaction_params, ip_request)
        return store_transaction;;
      else
        response
      end
    end

  end
end