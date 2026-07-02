class CreateAssemblyLineItems < ActiveRecord::Migration[8.1]
  def change
    create_table :assembly_line_items do |t|
      t.belongs_to :assembly
      t.integer :sequence
      t.integer :quantity
      t.timestamps
    end
  end
end
