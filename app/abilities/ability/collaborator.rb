class Ability::Collaborator < Ability
  def initialize(user)
    # Project
    can :read, Project do |project|
      user.projects.include? project
    end

    can :create, Project

    # Profile
    can :read, Profile

    # Requisite
    can :read, Requisite do |requisite|
      user.current_project.requisites.include? requisite
    end

    can :create, Requisite

    can :update, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.can_update? && requisite.proposed?
    end

    can :update_status, Requisite do |requisite|
      user.current_project.requisites.include?(requisite) &&
      requisite.responsable == user
    end
  end
end
