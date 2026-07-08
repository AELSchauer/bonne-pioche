class AddSupplierToComponents < ActiveRecord::Migration[8.1]
  def change
    add_reference :components, :supplier, foreign_key: { on_delete: :nullify }
  end
end
