class Ability
  include CanCan::Ability

  def initialize(current_user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    current_user ||= User.new

    if current_user.email == "gaurav.00g7@gmail.com"
      can :manage, :all
    else
      can :read, :all
      can :create, Comment
      unless current_user.nil?
        can :create, Article
      end
      can :update, Article do |article|
        article.email == current_user.email
      end
      can :destroy, Article do |article|
        article.email == current_user.email
      end

      can :update, Comment do |comment|
        comment.article.email == current_user.email
      end

      can :destroy, Comment do |comment|
        comment.article.email == current_user.email
      end

    end



    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
