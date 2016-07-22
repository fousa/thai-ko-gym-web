class User < ApplicationRecord
  self.inheritance_column = 'another_type_column'

  ### Authentication

  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  ### Enums

  enum role: [:member, :teacher, :admin]
  enum sex: [:m, :w]
  enum category: [:youth, :adults]
  enum type: [:competition, :amateur]
  enum rankings: [:a, :b, :c, :d, :j]

  ### scope

  scope :search, lambda { |query|
    searchable_fields = %w(first_name last_name city)
    where_query = searchable_fields.map { |f| "LOWER(#{f}) LIKE ?" }
    where_query = where_query.join(' OR ')
    value_query = searchable_fields.map { |_f| "%#{query.try(:downcase)}%" }
    where(where_query, *value_query)
  }

  ### Validations

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :sex,        presence: true
  validates :role,       presence: true

  ### Utilities

  def name
    [first_name, last_name].compact.join ' '
  end

  def age
    return nil if birth_date.nil?

    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(year: now.year) > now ? 1 : 0)
  end

  def country_name
    country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end

  ### CanCanCan

  def ability
    @ability ||= Ability.new(self)
  end

  delegate :can?, :cannot?, to: :ability

  def active_for_authentication?
    super && can?(:login, User)
  end

  ### Devise

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

  # new function to set the password without knowing the current
  # password used in our confirmation controller.
  def attempt_set_params(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    p[:confirmation_token] = nil
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def no_password?
    encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore.
  # Instead you should use `pending_any_confirmation`.
  def only_if_unconfirmed
    pending_any_confirmation { yield }
  end
end
