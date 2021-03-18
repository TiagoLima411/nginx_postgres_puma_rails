# Controller para endpoints Coingecko. Documentation => https://www.coingecko.com/pt/api#explore-api
class Api::CoingeckoController < ApiController
  skip_before_action :authorize_request, only: [:index]
  def index
    coins_list = Coingecko::Operation.coins_list
    json_response(coins_list, :ok)
  end
end
