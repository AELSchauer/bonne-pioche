class Component < ApplicationRecord
  include Part
  has_one_attached :image

  validates :name, presence: true, uniqueness: true
end
