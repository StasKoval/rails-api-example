class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :read,   Article, :all
      can :create, Article, :all
      # Update and destroy only articles that belongs to current user
      can [:update, :destroy], Article do |article|
        article.user_id == user.id
      end
    end
  end
end
