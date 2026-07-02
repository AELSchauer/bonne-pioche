class CreateComponents < ActiveRecord::Migration[8.1]
  def up
    execute "CREATE SEQUENCE components_sequential_number_seq START WITH 1 INCREMENT BY 1;"

    create_table :components do |t|
      t.string :type
      t.string :name
      t.string :sku_prefix, null: false
      t.integer :sku_number,
        null: false,
        default: -> { "nextval('components_sequential_number_seq')" }
      t.string :status
      t.string :tier
      t.integer :unit_of_measure
      t.virtual :sku,
        type: :string,
        as: "sku_prefix || '-' || sku_number",
        stored: true
      t.belongs_to :subcategory

      t.timestamps
    end

    add_index :components, :sku_number, unique: true
  end

  def down
    drop_table :components
    execute "DROP SEQUENCE components_sequential_number_seq;"
  end
end
