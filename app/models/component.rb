class Component < ApplicationRecord
  include Part
  belongs_to :subcategory
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
end
