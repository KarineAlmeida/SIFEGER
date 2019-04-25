class Profile < ApplicationRecord
  belongs_to :user
  belongs_to :project

  delegate :name, to: :user, prefix: true
  delegate :name, :owner_name, to: :project, prefix: true
end
