module RequisiteStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :state do
      state :proposed, initial: true
      state :under_evaluation, :approved, :rejected, :implemented, :tested, :concluded

      after_all_transitions :log_status_change

      event :to_propose do
        transitions from: [:under_evaluation, :approved, :rejected, :implemented, :tested, :concluded], to: :proposed
      end

      event :to_under_evaluation do
        transitions from: :proposed, to: :under_evaluation
      end

      event :to_approve do
        transitions from: :under_evaluation, to: :approved
      end

      event :to_reject do
        transitions from: :under_evaluation, to: :rejected
      end

      event :to_implement do
        transitions from: :approved, to: :implemented
      end

      event :to_test do
        transitions from: :implemented, to: :tested
      end

      event :to_conclude do
        transitions from: :tested, to: :concluded
      end
    end

    def log_status_change
      from_state = I18n.t(aasm.from_state, scope: 'views.requisite.states')
      to_state   = I18n.t(aasm.to_state, scope: 'views.requisite.states')

      changes = { changes: { state: "O estado do requisito foi alterado de <strong>#{from_state}</strong> para <strong>#{to_state}</strong>"}, kind: :status_change }
      log = RequisiteLog.create! title: 'Mudança de status.', version_changes: changes
      requisite_versions.create! object: reload.attributes, requisite_log: log, kind: :status_change
    end
  end
end
