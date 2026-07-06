class RemovePricingFromSupplierSkus < ActiveRecord::Migration[8.1]
  def change
    add_column :supplier_skus, :sku, :string
    remove_column :supplier_skus, :msrp_url, :string
    remove_column :supplier_skus, :msrp_cents, :integer
    remove_column :supplier_skus, :wholesale_per_unit_cost_cents, :virtual
    add_column :supplier_skus, :wholesale_per_unit_cost_cents, :integer
  end
end
