class Ability::Manager < Ability
  def initialize(user)
    # Project
    can :read, Project do |project|
      user.projects.include? project
    end

    can :create, Project

    can :update, Project do |project|
      user.current_profile.project == project
    end

    # Profile
    can :read, Profile
    can :create, Profile
    can :update, Profile do |profile|
      user.current_profile != profile
    end

    # Invitation
    can :create, Invitation
    can :update, Invitation do |invitation|
      invitation.email == user.email
    end
    can :delete, Invitation

    # Requisite
    can :read, Requisite do |requisite|
      user.current_project.requisites.include? requisite
    end

    can :create, Requisite

    can :update, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.can_update?
    end

    can :delete, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.can_destroy?
    end

    can :set_responsable, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.can_update?
    end

    can :update_status, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.responsable == user
    end
  end
end
