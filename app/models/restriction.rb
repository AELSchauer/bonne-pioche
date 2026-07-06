class Restriction < ApplicationRecord
  belongs_to :restrictable, polymorphic: true

  enum :name, {
    caffeine_free: "Caffeine-Free",
    gluten_free: "Gluten Free",
    kosher: "Kosher",
    nut_free: "Nut Free",
    organic: "Organic"
  }

  validates :name, presence: true, uniqueness: { scope: :restrictable }
end
