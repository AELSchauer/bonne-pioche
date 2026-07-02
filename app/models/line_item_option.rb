class LineItemOption < ApplicationRecord
  belongs_to :assembly_line_item
  belongs_to :option, polymorphic: true
end
