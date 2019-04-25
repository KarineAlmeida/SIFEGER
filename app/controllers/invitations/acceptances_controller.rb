class Invitations::AcceptancesController < ApplicationController
  layout 'invitation'

  skip_before_action :authenticate_user!

  before_action :set_invitation
  before_action :redirect_if_current_user

  def new
    @form = Invitation::AcceptanceForm.new({}, @invitation)
  end

  def create
    @form = Invitation::AcceptanceForm.new(acceptance_params, @invitation)

    if @form.save
      sign_in @form.user, scope: :user
      flash[:success] = 'Senha definida com sucesso.'
      redirect_to project_path(@form.invitation.project)
    else
      flash.now[:error] = 'Não foi possível definir a senha, verifique o formulário e tente novamente.'
      render :new
    end
  end

  private

  def redirect_if_current_user
    redirect_to root_path if current_user
  end

  def set_invitation
    @invitation = Invitation.find_by_token params[:token]
    redirect_to root_path unless @invitation
  end

  def acceptance_params
    params.require(:invitation_acceptance_form).permit(:name, :password, :password_confirmation, :accept)
  end

end
