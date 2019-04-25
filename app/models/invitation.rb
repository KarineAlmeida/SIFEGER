class Invitation < ApplicationRecord
  default_scope -> { where.not(status: ['accepted', 'rejected', 'deleted']) }

  belongs_to :project
  belongs_to :invited_by, foreign_key: :invited_by_id, class_name: 'User'

  before_create :set_token

  def cancel!
    update! status: 'deleted'
  end

  def accept!(user)
    ActiveRecord::Base.transaction do
      Profile.create! user: user, project: project, role: role
      user.update! current_project: project
      update! status: 'accepted'
    end
  end

  def reject!(user)
    update! status: 'rejected'
  end

  private

  def set_token
    self.token = Digest::MD5.hexdigest(SecureRandom.uuid)
  end
end
