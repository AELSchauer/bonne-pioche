class RemoveTypeFromSuppliers < ActiveRecord::Migration[8.1]
  def change
    remove_column :suppliers, :type, :string
  end
end
