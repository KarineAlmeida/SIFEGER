class AddPriorityToRequisite < ActiveRecord::Migration[5.1]
  def change
    add_column :requisites, :priority, :string
  end
end
