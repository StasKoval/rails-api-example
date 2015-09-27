class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # admin can manage anything
    if user.admin?
      can :manage, :all
    # user can read articles, but edit or destroy only articles belongs to
    else
      can :show,   Article
      can :index,  Article
      can :create, Article
      # Update and destroy only articles that belongs to current user
      can [:update, :destroy], Article do |article|
        article.user_id == user.id
      end
    end
  end
end
