class CreateSupplierSkus < ActiveRecord::Migration[8.1]
  def change
    create_table :supplier_skus do |t|
      t.string :name
      t.string :wholesale_url
      t.string :msrp_url
      t.integer :msrp_cents
      t.integer :wholesale_cost_cents
      t.integer :wholesale_quantity
      t.virtual :wholesale_per_unit_cost_cents,
        type: :integer,
        as: "CEILING(wholesale_cost_cents / wholesale_quantity)",
        stored: true

      t.timestamps
    end
  end
end
