module Part
  extend ActiveSupport::Concern
  include Restrictable

  included do
    belongs_to :subcategory

    enum :status, {
      draft: "draft",
      active: "active",
      inactive: "inactive",
      archived: "archived"
    }, default: :draft

    enum :tier, {
      common: "common",
      uncommon: "uncommon",
      rare: "rare",
      legendary: "legendary"
    }

    validates :name, presence: true
  end
end
