class InvitationForm < BaseForm

  attr_reader :name, :project, :role, :email

  validates :role, :email, :name, :project, presence: true
  validate :validate_profile_role, :validate_unique_email_by_project, :validate_unique_email_by_invitation

  def initialize(attributes, project)
    @project = project
    @email   = attributes[:email]
    @name    = attributes[:name]
    @role    = attributes[:role]
  end

  def available_profiles
    I18n.t('views.profile.roles').select { |key, value| key != :owner }.invert
  end

  def url
    routes.project_invitations_path(@project)
  end

  def create_and_invite
    return unless valid?

    begin
      user = User.find_by_email @email
      invitation = Invitation.create! project: @project, email: @email, name: @name, role: @role, invited_by_id: PaperTrail.request.whodunnit

      if user
        InvitationMailer.invite_to_project_mailer(invitation).deliver_now!
      else
        InvitationMailer.invite_to_platform_mailer(invitation).deliver_now!
      end
      true
    rescue => e
      errors.add(:base, 'Ocorreu um erro inexperado e não foi possível enviar o convite.')
      false
    end
  end

  private

  def validate_unique_email_by_project
    errors.add(:email, 'já pertence a outro perfil') if @project.users.pluck(:email).include?(@email)
  end

  def validate_unique_email_by_invitation
    errors.add(:email, 'já pertence a outro convite') if @project.invitations.pluck(:email).include?(@email)
  end


  def validate_profile_role
    return unless @role.present?
    errors.add(:role, 'não é valido') unless available_profiles.values.include? @role.to_sym
  end
end
