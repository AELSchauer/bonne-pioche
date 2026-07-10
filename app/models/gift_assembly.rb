class GiftAssembly < Assembly
  has_many :card_assemblies, foreign_key: :gift_assembly_id, dependent: :destroy
  has_many :cards, through: :card_assemblies

  enum :tier, {
    common: "common",
    uncommon: "uncommon",
    rare: "rare",
    legendary: "legendary"
  }
end
