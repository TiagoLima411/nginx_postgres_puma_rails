json.extract! account, :id, :bank_id, :agency_number, :account_number, :account_type, :created_at, :updated_at
json.url account_url(account, format: :json)
