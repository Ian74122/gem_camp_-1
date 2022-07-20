class AddSerialNumberToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :serial_number, :string
    add_index :posts, :serial_number
  end
end
