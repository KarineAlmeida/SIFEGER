class Permission < ApplicationRecord
  has_and_belongs_to_many :users

  validates :entity, :action, presence: true

  scope :project_actions, -> { where entity: 'Project' }

  def decorate
    return @decorate if @decorate

    @decorate = PermissionDecorator.new self
  end
end
