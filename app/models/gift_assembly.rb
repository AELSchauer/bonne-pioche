class GiftAssembly < Assembly
  has_many :card_assemblies, foreign_key: :gift_assembly_id, dependent: :destroy
  has_many :cards, through: :card_assemblies

  enum :tier, {
    common: "common",
    uncommon: "uncommon",
    rare: "rare",
    legendary: "legendary"
  }

  # Falls back to summing the MSRP of GFT-prefixed BOM line items (component
  # or sub-assembly) when no manual retail price has been set. A line item
  # with alternates uses the average MSRP across its primary option and all
  # alternates, rather than just the primary.
  def msrp_cents
    super || computed_msrp_cents
  end

  private

  def computed_msrp_cents
    gft_line_items = assembly_line_items.select { |line_item| line_item.primary_target&.sku_prefix == "GFT" }
    return nil if gft_line_items.empty?

    gft_line_items.sum { |line_item| average_option_msrp_cents(line_item) * line_item.quantity }
  end

  def average_option_msrp_cents(line_item)
    prices = line_item.line_item_options.filter_map { |option| option.option&.unit_msrp_cents }
    return 0 if prices.empty?

    (prices.sum.to_f / prices.size).round
  end
end
