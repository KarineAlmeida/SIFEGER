class UserDecorator < BaseDecorator
  def gravatar_url
    Gravatar.src(@component.email, 200)
  end
end
