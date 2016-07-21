class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    return if user.member?
    can :login, User
    can :read, User

    return if user.teacher?
    can :invite, User
    can :manage, User
  end
end
