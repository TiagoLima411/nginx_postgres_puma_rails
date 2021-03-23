class Bank < ApplicationRecord

  def self.generate(id, name, code, created_at = nil, updated_at = nil)
    bank = Bank.new
    bank.id = id
    bank.name = name
    bank.code = code
    bank.created_at = created_at.nil? ? Time.now : created_at
    bank.updated_at = updated_at.nil? ? Time.now : updated_at
    bank.save
  end
end
