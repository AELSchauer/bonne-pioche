class Exclusion < ApplicationRecord
  belongs_to :item, polymorphic: true

  enum :name, {
    caffeine_free: "Caffeine-Free",
    gluten_free: "Gluten Free",
    nut_free: "Nut Free"
  }
end
