class ActiveAdminAbility
  include CanCan::Ability

  def initialize(user)
    return unless user.is_a? AdminUser

    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"

    can :read, Project
    can :read, Permission
    can %i[read update], User
  end
end
