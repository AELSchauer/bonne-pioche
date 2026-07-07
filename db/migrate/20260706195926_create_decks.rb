class CreateDecks < ActiveRecord::Migration[8.1]
  def change
    create_table :decks do |t|
      t.string :name
      t.string :tier
      t.string :status

      t.timestamps
    end
  end
end
