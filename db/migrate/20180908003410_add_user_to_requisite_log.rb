class AddUserToRequisiteLog < ActiveRecord::Migration[5.1]
  def change
    add_reference :requisite_logs, :user, foreign_key: true
  end
end
