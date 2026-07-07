class RemoveSubcategoryFromComponents < ActiveRecord::Migration[8.1]
  def change
    remove_reference :components, :subcategory
  end
end
