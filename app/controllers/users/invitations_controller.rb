class Users::InvitationsController < ApplicationController
  def index
    @invitations = current_user.invitations
  end
end
