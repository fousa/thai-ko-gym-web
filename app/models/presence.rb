class Presence < ApplicationRecord
  ### Relations

  belongs_to :user
  belongs_to :registered_by, class_name: 'User', inverse_of: :registered_presences

  ### Validations

  validates :user,          presence: true
  validates :present_at,    presence: true
  validates :registered_by, presence: true
end
