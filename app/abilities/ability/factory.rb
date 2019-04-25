class Ability::Factory
  def self.build(user)
    case user.current_profile.try(:role).try(:to_sym)
      when :owner then Ability::Owner.new(user)
      when :manager then Ability::Manager.new(user)
      when :collaborator then Ability::Collaborator.new(user)
      when :member then Ability::Member.new(user)
    else
      Ability::WithoutProject.new(user)
    end
  end
end
