class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :card_assemblies, dependent: :destroy

  enum :tier, {
    common: "common",
    uncommon: "uncommon",
    rare: "rare",
    legendary: "legendary"
  }

  enum :status, {
    draft: "draft",
    active: "active",
    inactive: "inactive",
    archived: "archived"
  }, default: :draft

  validates :name, presence: true, uniqueness: true
end
