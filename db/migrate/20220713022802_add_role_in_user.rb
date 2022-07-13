class AddRoleInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :string, default: :client
  end
end
