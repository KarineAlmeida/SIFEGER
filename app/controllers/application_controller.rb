class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :admin_controller?
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound do
    render 'pages/404'
  end

  rescue_from StandardError do |exception|
    raise exception if Rails.env == 'development'

    render 'pages/500'
  end

  rescue_from CanCan::AccessDenied do |exception|
    raise exception if Rails.env == 'development'

    redirect_to projects_path
  end

  layout :layout_by_resource

  def current_ability
    @current_ability ||= Ability::Factory.build(current_user)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def admin_controller?
    controller.start_with? 'admin'
  end

  def after_sign_in_path_for(resource)
    return projects_path if resource.is_a? User
    super
  end

  private

  def layout_by_resource
    if controller == 'devise/registrations' && action == 'update'
      'application'
    elsif devise_controller? && !(devise_registration_controller? && action == 'edit')
      "user-auth"
    else
      "application"
    end
  end

  def devise_registration_controller?
    controller == 'devise/registrations'
  end

  def controller
    params[:controller]
  end

  def action
    params[:action]
  end
end
