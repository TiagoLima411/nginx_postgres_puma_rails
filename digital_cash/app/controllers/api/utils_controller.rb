class Api::UtilsController < ApiController
  skip_before_action :authorize_request, only: [:persist_coins_list, :persist_vs_currency]

  def persist_coins_list
    coins_list = Coingecko::Operation.coins_list
    coins_list.each do |coin|
      crypto_currencie = CryptoCurrencie.new(coin_id: coin['id'], symbol: coin['symbol'], name: coin['name']) if CryptoCurrencie.find_by(coin_id: coin['id']).nil?
      crypto_currencie.save
    end
    json_response({ msg: 'Concuído' }, :ok)
  end

  def persist_vs_currency
    vs_currency = Coingecko::Operation.vs_currency_list
    vs_currency.each do |currency|
      crypto_currencie = CryptoCurrencie.find_by(symbol: currency)
      Currency.create(symbol: currency, name: crypto_currencie.name) unless crypto_currencie.nil?
      Currency.create(symbol: currency, name: '') if crypto_currencie.nil?
    end
  end
end
