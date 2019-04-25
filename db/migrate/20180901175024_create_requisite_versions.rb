class CreateRequisiteVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :requisite_versions do |t|
      t.jsonb :object
      t.references :requisite, foreign_key: true
      t.references :requisite_log, foreign_key: true

      t.timestamps
    end
  end
end
