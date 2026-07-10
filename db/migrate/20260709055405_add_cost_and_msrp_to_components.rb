class AddCostAndMsrpToComponents < ActiveRecord::Migration[8.1]
  def change
    add_column :components, :msrp_cents, :integer
  end
end
