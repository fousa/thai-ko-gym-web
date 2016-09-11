class Presence < ApplicationRecord
  ### Relations

  belongs_to :user
  belongs_to :registered_by, class_name: 'User', inverse_of: :registered_presences

  ### Validations

  validates :user,          presence: true
  validates :present_at,    presence: true
  validates :registered_by, presence: true

  ### Scopes

  scope :for_month, lambda { |date|
    where('presences.present_at >= ? AND presences.present_at <= ?', date.beginning_of_month.beginning_of_day, date.end_of_month.end_of_day)
  }
end
