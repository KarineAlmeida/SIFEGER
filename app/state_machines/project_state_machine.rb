module ProjectStateMachine
  extend ActiveSupport::Concern

  included do
    include AASM

    aasm column: :status do
      state :created, initial: true
      state :finished

      event :finish do
        transitions from: :created, to: :finished
      end
    end
  end
end
