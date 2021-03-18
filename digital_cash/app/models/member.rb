class Member < ApplicationRecord
  
  belongs_to :city
  belongs_to :state
  has_one :user
  enum gender: %i[male female undefined]

  accepts_nested_attributes_for :user

  validates :email, presence: true, uniqueness: true
  validates :cpf, presence: true, uniqueness: true
  validates :address, presence: true
  validates :address_number, presence: true
  validates :district, presence: true
  validates :zipcode, presence: true

  validates_cpf_format_of :cpf

end
