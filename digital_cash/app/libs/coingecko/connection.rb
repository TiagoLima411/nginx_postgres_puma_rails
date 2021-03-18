require 'faraday'
require 'json'
module Coingecko
  # Classe de conexao com o Coingeck
  class Connection
    BASE = if Rails.env.production? || Rails.env.homologation?
            "https://api.coingecko.com/api/v3/"
           else
            "https://api.coingecko.com/api/v3/"
           end

    def self.api
      Faraday.new(url: BASE) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
        faraday.headers['Content-Type'] = 'application/json'
        # faraday.headers['Authorization'] = api_key
      end
    end

    # Token para auntenticacao da API
    def self.api_key
      return '9eqEmtTaFCdiUd3dOU3vaA' if Rails.env.production? || Rails.env.homologation?
      return '6K7ZzwNxygHnMYMeDxD2Xg' if Rails.env.development?
    end
  end
end
