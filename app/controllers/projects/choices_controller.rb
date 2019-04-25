class Projects::ChoicesController < ApplicationController

  def create
    project = Project.friendly.find(params[:project_id])

    authorize! :read, project
    current_user.set_current_project project.id
    redirect_to (project_path(project) + '#home')
  end

end
