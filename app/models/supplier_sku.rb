class SupplierSku < ApplicationRecord
  belongs_to :supplier
  has_many :supplier_sku_components, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :supplier_sku_components, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true

  def wholesale_cost
    wholesale_cost_cents && (wholesale_cost_cents / 100.0)
  end

  def wholesale_cost=(value)
    self.wholesale_cost_cents = value.presence && (value.to_f * 100).round
  end
end
