class CreateLineItemOptions < ActiveRecord::Migration[8.1]
  def change
    create_table :line_item_options do |t|
      t.boolean :is_primary
      t.belongs_to :assembly_line_item
      t.belongs_to :option, polymorphic: true

      t.timestamps
    end
  end
end
