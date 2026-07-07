class AddCardToAssemblies < ActiveRecord::Migration[8.1]
  def change
    add_reference :assemblies, :card, null: true, foreign_key: true
  end
end
