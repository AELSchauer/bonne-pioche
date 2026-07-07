class CreateCardAssemblies < ActiveRecord::Migration[8.1]
  def change
    create_table :card_assemblies do |t|
      t.references :deck, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.references :gift_assembly, null: false, foreign_key: { to_table: :assemblies }
      t.integer :position

      t.timestamps
    end

    add_index :card_assemblies, [ :deck_id, :gift_assembly_id ], unique: true, name: "index_card_assemblies_on_deck_and_gift_assembly"
  end
end
