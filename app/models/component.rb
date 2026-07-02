class Component < ApplicationRecord
  include Part
  belongs_to :subcategory
end
