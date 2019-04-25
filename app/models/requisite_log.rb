class RequisiteLog < ApplicationRecord
  belongs_to :user, required: false

  before_create :set_user

  def content
    version_changes['changes'].blank? ? {} : version_changes['changes']
  end

  def kind
    version_changes['kind']
  end

  private

  def set_user
    self.user_id = PaperTrail.request.whodunnit
  end

end
