class Requisite < ApplicationRecord
  include RequisiteStateMachine

  KINDS = [
    'Funcional',
    'Não funcional (Usabilidade)',
    'Não funcional (Manutenibilidade)',
    'Não funcional (Confiabilidade)',
    'Não funcional (Desempenho)',
    'Não funcional (Portabilidade)',
    'Não funcional (Reusabilidade)',
    'Não funcional (Segurança)',
    'Não funcional (Outro)',
  ].freeze
  PRIORITIES = %w(high medium low).freeze
  STATUSES   = %w(proposed under_evaluation rejected approved implemented tested concluded).freeze


  belongs_to :project
  belongs_to :author,      foreign_key: :author_id,      class_name: 'User'
  belongs_to :responsable, foreign_key: :responsable_id, class_name: 'User', required: false

  has_many :requisite_versions, dependent: :destroy, inverse_of: :requisite

  validates :slg, :kind, :title, :description, :author, :priority, :project, presence: true

  after_create  :create_version

  def decorate
    RequisiteDecorator.new(self)
  end

  def available_state_actions
    {
      proposed: %w[under_evaluation],
      under_evaluation: %w[approve reject],
      approved: %w[implement],
      rejected: [],
      implemented: %w[test],
      tested: %w[conclude],
      concluded: []
    }[state.to_sym]
  end

  def can_destroy?
    proposed? || under_evaluation?
  end

  def can_update?
    !(rejected? || concluded?)
  end

  private

  def create_version
    log = RequisiteLog.create! title: 'Requisito criado.', version_changes: { changes: {}, kind: :created }
    requisite_versions.create! object: attributes, requisite_log: log, kind: :created
  end
end
