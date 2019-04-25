class RemoveInvitedByIdFromInvitation < ActiveRecord::Migration[5.1]
  def change
    remove_column :invitations, :invited_by_id, :string
  end
end
