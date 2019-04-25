class RequisiteVersion < ApplicationRecord
  belongs_to :requisite, inverse_of: :requisite_versions
  belongs_to :requisite_log

  validates :kind, presence: true

  scope :filter_by_attribute_change, -> { where(kind: :attribute_change) }

  before_create :set_versions_count

  def decorate_requisite
    Requisite.new(object).decorate
  end

  private

  def set_versions_count
    new_version_count = requisite.requisite_versions.count + 1
    object['versions_count'] = new_version_count
    requisite.versions_count = new_version_count
    requisite.save
  end
end
