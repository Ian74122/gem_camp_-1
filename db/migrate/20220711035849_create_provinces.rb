class CreateProvinces < ActiveRecord::Migration[6.1]
  def change
    create_table :provinces do |t|
      t.string :code
      t.string :name
      t.belongs_to :region
      t.timestamps
    end
  end
end
