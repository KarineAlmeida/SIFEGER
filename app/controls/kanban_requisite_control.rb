class KanbanRequisiteControl < BaseControl
  def proposed
    @component.requisites.proposed
  end

  def approved
    @component.requisites.approved
  end

  def rejected
    @component.requisites.rejected
  end

  def under_evaluation
    @component.requisites.under_evaluation
  end

  def implemented
    @component.requisites.implemented
  end

  def tested
    @component.requisites.tested
  end

  def concluded
    @component.requisites.concluded
  end
end
