class Project < ApplicationRecord
  STATUSES = %w(pending finished).freeze

  include ProjectStateMachine
  extend FriendlyId
  friendly_id :name, use: :slugged

  validates :name, :conclusion_date, :description, presence: true
  validates :email, format: { with: Devise::email_regexp }, if: -> { email.present? }

  has_many :profiles, dependent: :destroy
  has_many :requisites, dependent: :destroy
  has_many :users, through: :profiles
  has_many :invitations, dependent: :destroy
  has_many :requisite_versions, through: :requisites

  validate :validate_conclusion_date

  delegate :name, to: :owner, prefix: true

  accepts_nested_attributes_for :profiles

  before_destroy :clear_current_project

  def decorate
    ProjectDecorator.new(self)
  end

  def owner
    profiles.where(role: :owner)[0].user
  end

  def flow_service
    ProjectFlowService.new(self)
  end

  def chart_control
    ProjectChartControl.new(self)
  end

  private

  def validate_conclusion_date
    return unless conclusion_date
    errors.add(:conclusion_date, 'deve ser maior do que hoje') if conclusion_date <= DateTime.current
  end

  def clear_current_project
    User.where(current_project_id: id).update_all(current_project_id: nil)
  end
end
