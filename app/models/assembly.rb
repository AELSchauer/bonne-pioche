class Assembly < ApplicationRecord
  include Part

  has_many :assembly_line_items, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :assembly_line_items, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true


  def msrp
    msrp_cents && (msrp_cents / 100.0)
  end

  def msrp=(value)
    self.msrp_cents = value.presence && (value.to_f * 100).round
  end

  # The cost/MSRP of one unit of this assembly, rolled up from the cost/MSRP
  # of its own line items (recursing into any nested sub-assemblies).
  def unit_cost_cents
    assembly_line_items.sum { |line_item| (line_item.primary_target&.unit_cost_cents || 0) * line_item.quantity }
  end

  def unit_msrp_cents
    assembly_line_items.sum { |line_item| (line_item.primary_target&.unit_msrp_cents || 0) * line_item.quantity }
  end
end
