class User::ProjectsControl < BaseControl

  def set_current_project(project_id)
    @component.update current_project_id: project_id
  end
end
