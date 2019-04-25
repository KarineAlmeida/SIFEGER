class Projects::Requisites::ResponsablesController < ApplicationController
  def update
    project = Project.friendly.find params[:project_id]

    authorize! :set_responsable, requisite

    @path = project_requisite_responsable_path(project, responsable_params[:requisite_id])
    @responsable_choice_form = Requisite::ResponsableChoiceForm.new(responsable_params, project)
    @clean_form              = Requisite::ResponsableChoiceForm.new({}, project)
    @responsable_choice_form.save
  end

  private

  def requisite
    @requisite ||= Requisite.find params[:requisite_id]
  end

  def responsable_params
    params.require(:requisite_responsable_choice_form).permit(:responsable_id).merge({requisite_id: requisite.id})
  end
end
