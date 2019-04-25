module ApplicationHelper
  def current_project_label
    if current_user.current_project
      "#{current_user.current_project.name} (#{I18n.t(current_user.current_profile.role, scope: 'views.profile.roles')})"
    else
      'Selecionar Projeto'
    end
  end

  def current_user_projects
    current_user.projects
  end

  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-error"
      when 'alert' then "alert alert-error"
    end
  end

  def requisite_log_icon_class(kind)
    case kind
      when 'created' then 'fa-check'
      when 'attribute_change' then 'fa-exchange'
      when 'add_responsable' then 'fa-user'
      when 'status_change' then 'fa-sliders'
    end
  end
end
