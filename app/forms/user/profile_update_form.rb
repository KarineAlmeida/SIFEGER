class User::ProfileUpdateForm < BaseForm

  attr_reader :name, :email, :role, :profile

  validates :role, presence: true
  validate :validate_role_permited

  def initialize(args={}, profile)
    @profile = profile
    @name    = profile.user.name
    @email   = profile.user.email
    @role    = args[:role] || profile.role
  end


  def url
    routes.project_profile_path(@profile.project, @profile)
  end

  def save
    return unless valid?
    @profile.update role: @role

  end

  def available_profiles
    I18n.t('views.profile.roles').select { |key, value| key != :owner }.invert
  end

  private

  def validate_role_permited
    errors.add(:role, 'não pode ser atruibuído') unless available_profiles.values.include? @role.to_sym
  end

end
