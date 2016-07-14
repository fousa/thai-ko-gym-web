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
end
