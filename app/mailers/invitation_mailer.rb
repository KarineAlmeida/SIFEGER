class InvitationMailer < ApplicationMailer

  def invite_to_platform_mailer(invitation)
    @invitation = invitation
    mail to: @invitation.email, subject: 'Bem vindo ao Sifeger | Você foi convidado para participar de um projeto.'
  end

  def invite_to_project_mailer(invitation)
    @invitation = invitation
    mail to: @invitation.email, subject: 'Sifeger | Você foi convidado para participar de um projeto.'
  end
end
