class AddMsrpToAssemblies < ActiveRecord::Migration[8.1]
  def change
    add_column :assemblies, :msrp_cents, :integer
    add_column :assemblies, :msrp_url, :string
  end
end
