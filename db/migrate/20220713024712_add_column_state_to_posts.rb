class AddColumnStateToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :state, :string
  end
end
