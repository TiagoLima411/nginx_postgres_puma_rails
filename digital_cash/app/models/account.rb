class Account < ApplicationRecord
  include Filterable

  belongs_to :bank
  belongs_to :user

  enum account_type: %i[cc cp]

  scope :actives, -> { where(active: true) }
  scope :bank_id, ->(bank_id) { where(bank_id: bank_id) }
  scope :kind, ->(type) { where(account_type: type) }
  scope :agency, ->(agency) { where(agency_number: agency) }
  scope :account_number, -> (account_number) { where(account_number: account_number) }

  def inactive
    self.update(active: false)
  end
end
