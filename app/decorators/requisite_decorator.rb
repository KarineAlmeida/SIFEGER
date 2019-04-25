class RequisiteDecorator < BaseDecorator
  delegate :versions_count, :slg, :title, :state, :description, :author, :project, :kind, to: :@component, prefix: false

  def created_at
    I18n.l(@component.created_at, format: :long)
  end

  def updated_at
    I18n.l(@component.updated_at, format: :long)
  end

  def priority
    I18n.t(@component.priority, scope: 'views.requisite.priorities')
  end

  def responsable_name
    @component.responsable.try(:name) || 'Não definido'
  end

  def state
    I18n.t(@component.state, scope: 'views.requisite.states')
  end

  def pretty_name
    "[#{slg}] #{title}"
  end

  def json
    {
      versions_count: versions_count,
      created_at: created_at,
      state: state,
      title: title,
      slg:   slg,
      description: description,
      kind: kind,
      priority: priority,
      responsable: responsable_name
    }.to_json
  end

end
