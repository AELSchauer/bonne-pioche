class LineItemOption < ApplicationRecord
  belongs_to :assembly_line_item
  belongs_to :option, polymorphic: true

  validates :option, presence: true

  def option_ref
    "#{option_type}-#{option_id}" if option_type && option_id
  end

  def option_ref=(value)
    type, id = value.to_s.split("-", 2)
    self.option_type = type
    self.option_id = id
  end
end
