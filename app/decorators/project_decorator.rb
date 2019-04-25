class ProjectDecorator < BaseDecorator
  def conclusion_percentage
    "#{@component.flow_service.conclusion_percentage}%"
  end

  def status
    I18n.t(@component.status, scope: 'views.project')
  end

  def status_label
    @component.finished? ? 'success' : 'default'
  end

  def pretty_name
    return @component.name unless @component.acronyms.present?

    "#{@component.name} (#{@component.acronyms})"
  end

end
