class RestrictionName < ApplicationRecord
  has_many :restrictions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
end
