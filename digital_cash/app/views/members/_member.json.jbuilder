json.extract! member, :id, :name, :email, :birthday, :cpf, :phone, :address, :zipcode, :city_id, :state_id, :complement, :number, :district, :created_at, :updated_at
json.url member_url(member, format: :json)
