class Supplier < ApplicationRecord
  has_many :supplier_skus, dependent: :destroy
  has_many :components

  validates :name, presence: true, uniqueness: true
  validates :sourcing_channel, presence: true
  validates :account_status, presence: true
  validates :min_order_dollars, presence: true
end
