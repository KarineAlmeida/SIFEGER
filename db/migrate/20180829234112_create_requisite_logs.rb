class CreateRequisiteLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :requisite_logs do |t|
      t.string :title
      t.jsonb :version_changes, default: {}

      t.timestamps
    end
  end
end
