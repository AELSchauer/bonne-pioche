class AddDetailsToSuppliers < ActiveRecord::Migration[8.1]
  def change
    add_column :suppliers, :website_url, :string
    add_column :suppliers, :description, :text
    add_column :suppliers, :sourcing_channel, :string
    add_column :suppliers, :account_status, :string
    add_column :suppliers, :min_order_dollars, :integer
    add_column :suppliers, :min_order_free_shipping, :integer
    add_column :suppliers, :lead_time, :string
    add_column :suppliers, :notes, :text
  end
end
