class Component < ApplicationRecord
  include Part
  has_one_attached :image
  belongs_to :supplier, optional: true
  has_many :supplier_sku_components
  has_many :supplier_skus, through: :supplier_sku_components

  enum :unit_of_measure, { ea: 0, pack: 1, set: 2, grams: 3, liters: 4 }, default: :ea

  UNIT_LABELS = { "ea" => "ea", "pack" => "pack", "set" => "set", "grams" => "g", "liters" => "L" }.freeze

  validates :name, presence: true, uniqueness: true

  def msrp
    msrp_cents && (msrp_cents / 100.0)
  end

  def msrp=(value)
    self.msrp_cents = value.presence && (value.to_f * 100).round
  end

  # The costlier of the supplier SKUs this component is sourced through,
  # so BOM costing never understates what a unit could actually cost.
  def unit_cost_cents
    supplier_skus.maximum(:wholesale_per_unit_cost_cents)
  end

  def unit_msrp_cents
    msrp_cents
  end

  def unit_label
    UNIT_LABELS.fetch(unit_of_measure, unit_of_measure)
  end
end
