class Restriction < ApplicationRecord
  belongs_to :restrictable, polymorphic: true

  enum :name, {
    caffeine_free: "Caffeine-Free",
    gluten_free: "Gluten Free",
    nut_free: "Nut Free"
  }
end
