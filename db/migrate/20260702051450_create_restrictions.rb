class CreateRestrictions < ActiveRecord::Migration[8.1]
  def change
    create_table :restrictions do |t|
      t.bigint :restrictable_id
      t.string :restrictable_type
      t.string :name

      t.timestamps
    end
  end
end
