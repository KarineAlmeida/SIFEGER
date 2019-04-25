class AddCurrentProjectToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_project_id, :integer
  end
end
