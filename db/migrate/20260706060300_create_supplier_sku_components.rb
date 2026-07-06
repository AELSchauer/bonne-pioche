class CreateSupplierSkuComponents < ActiveRecord::Migration[8.1]
  def change
    create_table :supplier_sku_components do |t|
      t.belongs_to :supplier_sku, null: false, foreign_key: true
      t.belongs_to :component, null: false, foreign_key: true
      t.string :msrp_url
      t.integer :msrp_cents
      t.integer :wholesale_cost_cents

      t.timestamps
    end

    add_index :supplier_sku_components, [ :supplier_sku_id, :component_id ], unique: true
  end
end
