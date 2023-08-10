class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Group

    can :manage, :all if user.role == 'admin'

    return unless user.role == 'user'

    can :manage, Group, user_id: user.id
    can :manage, User, id: user.id
    can :manage, Movement, user_id: user.id
  end
end
