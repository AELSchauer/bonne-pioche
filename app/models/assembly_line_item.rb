class AssemblyLineItem < ApplicationRecord
  belongs_to :assembly
  has_many :line_item_options, dependent: :destroy
  accepts_nested_attributes_for :line_item_options, allow_destroy: true, reject_if: :all_blank

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validate :exactly_one_primary_option

  private

  def exactly_one_primary_option
    active_options = line_item_options.reject(&:marked_for_destruction?)
    return if active_options.empty?

    errors.add(:base, "must have exactly one primary component or sub-assembly") unless active_options.count(&:is_primary?) == 1
  end
end
