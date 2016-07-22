class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return if user.member?
    can :login, User
    can :read, User
    can :active, User
    can :inactive, User

    return if user.teacher?
    can :manage, User
  end
end
