FactoryBot.define do
  factory :recharge do

    #pagseguro_payment_method { %w[credit_card billet debit_online].sample } 
    pagseguro_payment_method { 'credit_card' } 
    #pagseguro_status { %w[awaiting_payment in_analysis paid available in_dispute returned canceled].sample }
    pagseguro_status { 'in_analysis'  }
    gross_value_cents { 1000 }
    discount_value_cents { 0 }
    installment_fee_amount { 1.0 }
    intermediation_rate_amount { 0.40 }
    intermediation_fee_amount { 0.50 }
    net_value_cents { 910 }
    extra_value_cents { 0 }
    installment_count { 1 }
    item_count { 1 }
    code { '1' }
    payment_method_code { '1' }
    authorizationCode { '1' }
    nsu { '1' }
    tid { '1' }
    establishment_code { '1' }
    acquirer_Name { '1' }
    primary_receiver_key { '1' }
    date { Time.now }
    transaction_date { Time.now }
    last_event_date { Time.now }
    description { 'Recarga em conta' }

    user
  end
  
end
