class Projects::ProfilesController < ApplicationController

  def edit
    profile = Project.friendly.find(params[:project_id]).profiles.find params[:id]

    authorize! :update, profile
    @form = User::ProfileUpdateForm.new({}, profile)
  end


  def update
    profile = Project.friendly.find(params[:project_id]).profiles.find params[:id]

    authorize! :update, profile
    @form = User::ProfileUpdateForm.new(update_profile_params, profile)

    if @form.save
      flash[:success] = 'Perfil do Membro atualizado com sucesso.'
      redirect_to project_invitations_path(current_user.current_project) + '#members'
    else
      flash.now[:error] = 'Não foi possível atualizar o perfil, verifique o formulário e tente novamente.'
      render :edit
    end

  end

  private

  def update_profile_params
    params.require(:user_profile_update_form).permit(:role)
  end

end
