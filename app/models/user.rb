class User < ApplicationRecord
  ### Authentication
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  ### Enums
  enum sex: [:m, :w]
  enum category: [:youth, :adults]
  enum type: [:competition, :amateur]
  enum rankings: [:a, :b, :c, :d, :j]

  ### Validations
  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :sex,        presence: true

  ### devise
  def password_required?
    # Password is required if it is being set, but not for new records
    if !persisted?
      false
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  def email_required?
    !confirmed_at.nil?
  end
end
