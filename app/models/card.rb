class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_assemblies, dependent: :destroy
  has_many :gift_assemblies, through: :card_assemblies
  has_one_attached :image

  enum :status, {
    draft: "draft",
    active: "active",
    inactive: "inactive",
    archived: "archived"
  }, default: :draft

  validates :name, presence: true, uniqueness: true
end
