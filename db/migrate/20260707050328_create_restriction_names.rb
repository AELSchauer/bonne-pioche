class CreateRestrictionNames < ActiveRecord::Migration[8.1]
  def change
    create_table :restriction_names do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :restriction_names, :name, unique: true
  end
end
