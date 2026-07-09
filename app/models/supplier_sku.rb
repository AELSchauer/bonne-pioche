class SupplierSku < ApplicationRecord
  belongs_to :supplier
  has_many :supplier_sku_components, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :supplier_sku_components, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validate :wholesale_quantity_matches_component_sum

  def wholesale_cost
    wholesale_cost_cents && (wholesale_cost_cents / 100.0)
  end

  def wholesale_cost=(value)
    self.wholesale_cost_cents = value.presence && (value.to_f * 100).round
  end

  private

  def wholesale_quantity_matches_component_sum
    active_components = supplier_sku_components.reject(&:marked_for_destruction?)
    return if wholesale_quantity.blank? && active_components.empty?

    component_quantity_sum = active_components.sum { |c| c.quantity.to_i }
    return if wholesale_quantity == component_quantity_sum

    errors.add(:wholesale_quantity, "must equal the sum of component quantities (currently #{component_quantity_sum})")
  end
end
