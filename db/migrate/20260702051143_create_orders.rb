class CreateOrders < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE SEQUENCE orders_sequential_number_seq START WITH 1 INCREMENT BY 1;"

    create_table :orders do |t|
      t.integer :order_number,
        null: false,
        default: -> { "nextval('orders_sequential_number_seq')" }
      t.string :status

      t.timestamps
    end

    add_index :orders, :order_number, unique: true
  end

  def down
    drop_table :orders
    execute "DROP SEQUENCE orders_sequential_number_seq;"
  end
end
