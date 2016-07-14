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
end
