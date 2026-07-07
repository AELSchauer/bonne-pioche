class SupplierSkuComponent < ApplicationRecord
  belongs_to :supplier_sku
  belongs_to :component

  validates :component_id, uniqueness: { scope: :supplier_sku_id, message: "is already on this SKU" }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
