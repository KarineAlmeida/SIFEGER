class Ability::WithoutProject < Ability
  def initialize(user)
    # Project
    can :read, Project do |project|
      user.projects.include? project
    end
    can :create, Project
  end
end
