class DropSubcategoriesAndCategories < ActiveRecord::Migration[8.1]
  def up
    drop_table :subcategories
    drop_table :categories
  end

  def down
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :subcategories do |t|
      t.string :name
      t.belongs_to :category, null: false

      t.timestamps
    end
  end
end
