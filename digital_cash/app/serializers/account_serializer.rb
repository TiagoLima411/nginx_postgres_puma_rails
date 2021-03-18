class AccountSerializer < ApplicationSerializer
  attributes :id, :agency_number, :account_number, :account_type
  has_one :bank
  has_one :user
  class UserSerializer < ApplicationSerializer
    attributes :id, :active, :role, :name
    
    def name
      object.member.name
    end
  end
end
