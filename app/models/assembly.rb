class Assembly < ApplicationRecord
  include Part

  has_many :assembly_line_items, -> { order(:id) }, dependent: :destroy
  accepts_nested_attributes_for :assembly_line_items, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true, uniqueness: true
end
