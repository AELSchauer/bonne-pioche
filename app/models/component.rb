class Component < ApplicationRecord
  include Part
  has_one_attached :image
  belongs_to :supplier, optional: true

  validates :name, presence: true, uniqueness: true
end
