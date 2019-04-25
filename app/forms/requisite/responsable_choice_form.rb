class Requisite::ResponsableChoiceForm < BaseForm

  attr_reader :responsable_id, :requisite_id

  validates :responsable_id, presence: true

  def initialize(attributes, project)
    @old_requisite_id = nil
    @project          = project
    @responsable_id   = attributes[:responsable_id]
    @requisite_id     = attributes[:requisite_id]
  end

  def responsables
    @project.users.map { |n| [n.name, n.id]}
  end

  def responsable
    return unless @responsable_id.present?
    @responsable ||= User.find @responsable_id
  end

  def requisite
    return unless @requisite_id.present?
    @requisite ||= Requisite.find @requisite_id
  end

  def save
    return unless valid?
    return true if requisite.responsable == responsable

    ActiveRecord::Base.transaction do
      requisite.update! responsable: responsable

      changes = { changes: { responsable: "<strong>#{requisite.responsable.name}</strong> foi definido como responável do requisito."}, kind: :add_responsable }

      log = RequisiteLog.create title: 'Responsável adicionado', version_changes: changes
      requisite.requisite_versions.create! object: requisite.attributes, requisite_log: log, kind: :add_responsable
    end
  end
end
