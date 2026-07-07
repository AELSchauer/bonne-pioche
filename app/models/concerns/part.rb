module Part
  extend ActiveSupport::Concern
  include Restrictable

  included do
    enum :status, {
      draft: "draft",
      active: "active",
      inactive: "inactive",
      archived: "archived"
    }, default: :draft

    validates :name, presence: true
  end
end
