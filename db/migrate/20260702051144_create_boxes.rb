class CreateBoxes < ActiveRecord::Migration[8.1]
  def change
    create_table :boxes do |t|
      t.string :name
      t.string :status
      t.belongs_to :order

      t.timestamps
    end
  end
end
