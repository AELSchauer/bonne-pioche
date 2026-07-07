class RestructureSupplierSkuComponentsPricing < ActiveRecord::Migration[8.1]
  def change
    remove_column :supplier_sku_components, :wholesale_per_unit_cost_cents, :virtual
    remove_column :supplier_sku_components, :wholesale_cost_cents, :integer
    remove_column :supplier_sku_components, :wholesale_quantity, :integer
    remove_column :supplier_sku_components, :wholesale_url, :string
    remove_column :supplier_sku_components, :msrp_cents, :integer
    remove_column :supplier_sku_components, :msrp_url, :string
    add_column :supplier_sku_components, :quantity, :integer
  end
end
