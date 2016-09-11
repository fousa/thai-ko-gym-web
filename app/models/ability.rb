class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return if user.member?
    can :login, User
    can :read, User
    can :active, User
    can :inactive, User

    can :read, Presence

    return if user.teacher?
    can :manage, User
    can :manage, Presence
  end
end
