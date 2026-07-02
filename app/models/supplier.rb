class Supplier < ApplicationRecord
  enum :type, {
    caffeine_free: "Caffeine-Free",
    gluten_free: "Gluten Free",
    nut_free: "Nut Free"
  }
end
