class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.string :state, null: false
      t.datetime :paid_at, precision: 6
      t.timestamps
    end
  end
end
