class Assembly < ApplicationRecord
  include Part

  has_many :assembly_line_items, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :assembly_line_items, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true

  def msrp
    msrp_cents && (msrp_cents / 100.0)
  end

  def msrp=(value)
    self.msrp_cents = value.presence && (value.to_f * 100).round
  end
end
