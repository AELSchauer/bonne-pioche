class RemoveCardFromAssemblies < ActiveRecord::Migration[8.1]
  def change
    remove_reference :assemblies, :card, foreign_key: true
  end
end
