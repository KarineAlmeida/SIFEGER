class CreateRequisites < ActiveRecord::Migration[5.1]
  def change
    create_table :requisites do |t|
      t.string :slg
      t.string :kind
      t.string :title
      t.text :description
      t.string :state, default: 'proposed'
      t.bigint :author_id
      t.bigint :responsable_id
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
