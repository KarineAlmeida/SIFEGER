class Projects::StatusesController < ApplicationController

  def update
    project = Project.friendly.find(params[:project_id])
    project.finish!
    flash[:success] = 'Projeto finalizado com sucesso.'
    redirect_to project_path(project)
  end
end
