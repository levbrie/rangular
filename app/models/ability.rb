class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role?(:admin)
      can :manage, :all
    else
      can :read, :all if user.has_role? :developer
      can :read, :users if user.has_role? :user
    end
  end
end
