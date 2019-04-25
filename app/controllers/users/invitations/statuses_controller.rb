class Users::Invitations::StatusesController < ApplicationController

  def update
    invitation = Invitation.find params[:invitation_id]

    authorize! :update, invitation
    invitation.send("#{params[:status]}!", current_user)

    if params[:status] == 'accept'
      flash['success'] = 'Convite aceito com sucesso.'
      redirect_to project_path(invitation.project)
    else
      flash['success'] = 'Convite rejeitado com sucesso.'
      redirect_to users_invitations_path
    end
  end
end
