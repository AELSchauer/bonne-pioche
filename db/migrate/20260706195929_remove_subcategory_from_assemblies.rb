class RemoveSubcategoryFromAssemblies < ActiveRecord::Migration[8.1]
  def change
    remove_reference :assemblies, :subcategory
  end
end
