class CreateSuppliers < ActiveRecord::Migration[8.1]
  def change
    create_table :suppliers do |t|
      t.string :type
      t.string :name

      t.timestamps
    end
  end
end
