MoneyRails.configure do |config|

  # set the default currency
  config.default_currency = :brl

  Money.locale_backend = :currency

end
