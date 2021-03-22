class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  validates :username, uniqueness: true
  validates :username, presence: true, format: { with: /\A^[0-9a-zA-Z]*$\z/, message: "só pode conter letras e números."}


  def active_for_authentication?
    super && active
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?; end

end
