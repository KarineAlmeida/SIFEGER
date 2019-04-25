class CreateJoinTablePermissionsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :permissions_users, :id => false do |t|
      t.references :permission, :null => false
      t.references :user, :null => false
    end

    add_index(:permissions_users, [:permission_id, :user_id], :unique => true)
  end
end
