class RemoveProfileIdFromInvitation < ActiveRecord::Migration[5.1]
  def change
    remove_column :invitations, :profile_id, :string
  end
end
