class AssemblyLineItem < ApplicationRecord
  belongs_to :assembly
  has_many :line_item_options, dependent: :destroy
  accepts_nested_attributes_for :line_item_options, allow_destroy: true, reject_if: :all_blank

  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
