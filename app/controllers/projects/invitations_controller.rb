class Projects::InvitationsController < ApplicationController
  before_action :set_project

  def index
    @profiles = @project.profiles.includes(:user)
    @invitations = @project.invitations

    authorize! :read, Profile
  end

  def new
    @form = InvitationForm.new({}, @project)

    authorize! :create, Invitation
  end

  def create
    @form = InvitationForm.new invitation_form_attributes, @project

    authorize! :create, Invitation
    if @form.create_and_invite
      flash[:success] = 'Convite enviado com sucesso.'
      redirect_to project_invitations_path(@project) + '#invites'
    else
      flash.now[:error] = 'Não foi possível enviar o convite, verifique o formulário e tente novamente.'
      render :new
    end
  end

  def destroy
    @invitation = Invitation.find params[:id]

    authorize! :delete, Invitation

    @invitation.cancel!
    flash[:success] = 'Convite excluído com sucesso.'
    redirect_to project_invitations_path(@project) + '#invites'
  end

  private

  def set_project
    @project = current_user.current_project
  end

  def invitation_form_attributes
    params.require(:invitation_form).permit(:name, :email, :role)
  end
end
