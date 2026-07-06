class Assembly < ApplicationRecord
  include Part

  validates :name, presence: true, uniqueness: true
end
