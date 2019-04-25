class PermissionDecorator < BaseDecorator

  def entity
    I18n.t @component.entity.downcase, scope: 'views.permission.entities'
  end

  def action
    I18n.t @component.action, scope: 'views.permission.actions'
  end
end
