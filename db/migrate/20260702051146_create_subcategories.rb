class CreateSubcategories < ActiveRecord::Migration[8.1]
  def change
    create_table :subcategories do |t|
      t.string :name
      t.belongs_to :category, null: false

      t.timestamps
    end
  end
end
