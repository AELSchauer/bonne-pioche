class AddSupplierToSupplierSkus < ActiveRecord::Migration[8.1]
  def change
    add_reference :supplier_skus, :supplier, null: false, foreign_key: true
  end
end
