class BaseForm
  include ActiveModel::Model

  protected

  def routes
    Rails.application.routes.url_helpers
  end
end
