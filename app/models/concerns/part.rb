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

    before_validation :assign_sku_number, on: :create
  end

  private

  def assign_sku_number
    return if sku_number.present?

    loop do
      candidate = rand(10_000_000..99_999_999)
      next if self.class.unscoped.exists?(sku_number: candidate)

      self.sku_number = candidate
      break
    end
  end
end
