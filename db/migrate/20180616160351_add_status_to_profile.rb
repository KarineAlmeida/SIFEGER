class AddStatusToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :status, :string, default: :active
  end
end
