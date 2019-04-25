class AddVersionsCountToRequisite < ActiveRecord::Migration[5.1]
  def change
    add_column :requisites, :versions_count, :integer, default: 0
  end
end
