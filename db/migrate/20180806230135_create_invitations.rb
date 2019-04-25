class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :token
      t.references :project, foreign_key: true
      t.string :invited_by_id
      t.references :profile, foreign_key: true
      t.string :status, default: :pending

      t.timestamps
    end
  end
end
