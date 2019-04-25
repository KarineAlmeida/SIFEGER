class ProjectFlowService

  def initialize(project)
    @project = project
  end

  def conclusion_percentage
    return 100 if all_requisites.empty?

    ((all_concluded_requisites.count + all_rejected_requisites.count).to_f / all_requisites.count.to_f * 100.0).round
  end

  def can_finish?
    conclusion_percentage == 100 && !@project.finished?
  end

  def all_requisites
    @project.requisites
  end

  def all_concluded_requisites
    @project.requisites.where(state: 'concluded')
  end

  def all_rejected_requisites
    @project.requisites.where(state: 'rejected')
  end

end
