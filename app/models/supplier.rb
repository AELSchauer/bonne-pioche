class Supplier < ApplicationRecord
  has_many :supplier_skus, dependent: :destroy

  validates :name, presence: true
end
