class AddKindToRequisiteVersion < ActiveRecord::Migration[5.1]
  def change
    add_column :requisite_versions, :kind, :string
  end
end
