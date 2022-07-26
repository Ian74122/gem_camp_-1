class AddCountryCityInUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :country, :string, default: nil
    add_column :users, :city, :string, default: nil
  end
end
