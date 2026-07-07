class RemoveTierFromComponents < ActiveRecord::Migration[8.1]
  def change
    remove_column :components, :tier, :string
  end
end
