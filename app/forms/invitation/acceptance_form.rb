class Invitation::AcceptanceForm < BaseForm
  ACCEPT_FORM_VALUE = '1'

  attr_accessor :name, :email, :password, :password_confirmation, :accept, :invitation, :user

  validates :name, :password, :password_confirmation, presence: true
  validate :password_should_be_equal_to_confirmation, :accept_should_be_true

  def initialize(attributes, invitation)
    @invitation            = invitation
    @name                  = attributes[:name] || @invitation.name
    @email                 = @invitation.email
    @password              = attributes[:password]
    @password_confirmation = attributes[:password_confirmation]
    @accept                = attributes[:accept] || false
  end

  def url
    routes.invitations_acceptances_path(token: invitation.token)
  end

  def save
    return unless valid?

    begin
      ActiveRecord::Base.transaction do
        project = @invitation.project
        @user = User.create! email: @email, name: @name, password: @password, current_project: project
        Profile.create user: user, project: project, role: @invitation.role
        @invitation.update! status: 'accepted'
      end
    rescue => e
      errors.add(:base, 'Ocorreu um erro inexperado e não foi possível aceitar o convite.')
      false
    end
  end

  private

  def password_should_be_equal_to_confirmation
    errors.add(:password, 'está diferente da confirmação da senha') if @password != @password_confirmation
  end

  def accept_should_be_true
    errors.add(:accept, 'deve ser marcado para avançar') if @accept != ACCEPT_FORM_VALUE
  end
end
