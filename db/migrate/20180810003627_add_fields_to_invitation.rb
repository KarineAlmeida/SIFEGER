class AddFieldsToInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :email, :string
    add_column :invitations, :name, :string
    add_column :invitations, :role, :string
  end
end
