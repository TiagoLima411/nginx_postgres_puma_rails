class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  belongs_to :member, optional: true
  
  has_one :account
  has_one :account_balance
  has_many :incomes
  has_many :outgoings
  has_many :recharges

  validates :username, uniqueness: true
  validates :username, presence: true, format: { with: /\A^[0-9a-zA-Z]*$\z/, message: "só pode conter letras e números."}

  after_create :create_account_balance

  enum role: %i[root member api]
  accepts_nested_attributes_for :member

  # DEVISE METHODS

  def active_for_authentication?
    super && active
  end

  def resetPassword
    if !self.root?
      self.password = '123123123'
      return self.save
    end
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?; end

  def create_account_balance
    if self.member?
      AccountBalance.generate(self)
    end
  end

  def set_payment_password(payment_password)
    self.update(payment_password: BCrypt::Password.create(payment_password))
  end

  def self.valid_payment_password?(cpf, payment_password)
    response = false
    user = User.joins(:member).find_by(members: {cpf: cpf})

    begin
      user_password = BCrypt::Password.new(user.payment_password)
      response = user_password == payment_password unless user.nil? || user.payment_password.nil?
    rescue BCrypt::Errors::InvalidHash
      return nil
    end

    return nil if !response
    return user if !user.nil? && user.member.cpf.eql?(cpf) && response
  end

end
