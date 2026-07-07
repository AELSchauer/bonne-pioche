class Restriction < ApplicationRecord
  belongs_to :restrictable, polymorphic: true
  belongs_to :restriction_name

  delegate :name, to: :restriction_name, allow_nil: true

  validates :restriction_name_id, presence: true, uniqueness: { scope: :restrictable }
end
