class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :profiles
  has_many :projects, through: :profiles

  has_many :requisites, foreign_key: :responsable_id, class_name: 'Requisite'

  belongs_to :current_project, foreign_key: :current_project_id, class_name: 'Project', required: false

  validates :name, presence: true

  delegate :set_current_project, to: :projects_control
  delegate :gravatar_url, to: :decorate

  def decorate
    UserDecorator.new(self)
  end

  def projects_control
    User::ProjectsControl.new(self)
  end

  def invitations
    ::Invitation.where(email: email)
  end

  def current_profile
    profiles.where(project: current_project)[0]
  end
end
