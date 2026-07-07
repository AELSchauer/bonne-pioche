class GiftAssembly < Assembly
  has_many :card_assemblies, foreign_key: :gift_assembly_id, dependent: :destroy
  has_many :cards, through: :card_assemblies

  enum :tier, {
    common: "common",
    uncommon: "uncommon",
    rare: "rare",
    legendary: "legendary"
  }

  # A gift assembly can technically hold a card per deck (the CardAssembly
  # invariant), but the assembly form only manages a single one for now.
  def card
    cards.first
  end

  def card_id
    card&.id
  end
end
