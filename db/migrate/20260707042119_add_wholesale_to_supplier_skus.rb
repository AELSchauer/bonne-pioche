class AddWholesaleToSupplierSkus < ActiveRecord::Migration[8.1]
  def change
    add_column :supplier_skus, :wholesale_cost_cents, :integer
    add_column :supplier_skus, :wholesale_quantity, :integer
    add_column :supplier_skus, :wholesale_url, :string
    add_column :supplier_skus, :wholesale_per_unit_cost_cents, :virtual,
      type: :integer,
      as: "ceiling(((wholesale_cost_cents / wholesale_quantity))::double precision)",
      stored: true
  end
end
