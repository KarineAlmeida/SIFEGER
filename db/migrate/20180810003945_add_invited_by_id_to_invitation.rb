class AddInvitedByIdToInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :invited_by_id, :bigint
  end
end
