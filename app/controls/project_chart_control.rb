class ProjectChartControl < BaseControl
  COLORS = ['#f44336', '#e91e63', '#9c27b0', '#3f51b5', '#03a9f4', '#009688', '#8bc34a', '#ffeb3b', '#ff9800', '#795548', '#9e9e9e', '#607d8b']
  STATUS_COLOR = ['#607d8b', '#e91e63', '#f44336', '#4caf50', '#3f51b5', '#ff9800', '#8bc34a']

  def statuses_chart
    array = cached_requisites.to_a
    {
      labels: Requisite::STATUSES.map { |status| I18n.t(status, scope: 'views.requisite.states')},
      values: Requisite::STATUSES.map { |status| array.select { |requisite| requisite.state == status }.size },
      colors: STATUS_COLOR.take(Requisite::STATUSES.size)
    }.to_json
  end

  def changes_history
    versions_ocurrences = cached_requisites.all.map { |requisite| requisite.requisite_versions.filter_by_attribute_change.count }
    uniq_ocurrences = versions_ocurrences.uniq.sort

    {
      labels: uniq_ocurrences.map { |value| "#{value} versões"},
      values: uniq_ocurrences.map { |value| versions_ocurrences.count(value) },
      colors: COLORS.take(uniq_ocurrences.size)
    }.to_json
  end

  def requisites_by_responsable
    responsables = cached_requisites.map(&:responsable).compact.uniq

    {
      labels: responsables.map(&:name),
      values: responsables.map { |responsable| responsable.requisites.count },
      colors: COLORS.take(responsables.size)
    }.to_json
  end

  private

  def cached_requisites
    @cached_requisites ||= @component.requisites.includes(:responsable, requisite_versions: :requisite_log)
  end

end
