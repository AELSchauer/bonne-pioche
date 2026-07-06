class AddSkuToSupplierSkus < ActiveRecord::Migration[8.1]
  def change
    add_column :supplier_skus, :sku, :string
  end
end
