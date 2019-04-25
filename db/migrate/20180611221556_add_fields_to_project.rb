class AddFieldsToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :acronyms, :string
    add_column :projects, :description, :text
    add_column :projects, :conclusion_date, :datetime
    add_column :projects, :status, :string, default: :created
    add_column :projects, :email, :string
    add_column :projects, :site, :string
  end
end
