class RemoveSequentialNumberSequences < ActiveRecord::Migration[8.1]
  def up
    change_column_default :assemblies, :sku_number, nil
    change_column_default :components, :sku_number, nil
    change_column_default :orders, :order_number, nil

    execute "DROP SEQUENCE IF EXISTS assemblies_sequential_number_seq;"
    execute "DROP SEQUENCE IF EXISTS components_sequential_number_seq;"
    execute "DROP SEQUENCE IF EXISTS orders_sequential_number_seq;"
  end

  def down
    execute "CREATE SEQUENCE assemblies_sequential_number_seq START WITH 1 INCREMENT BY 1;"
    execute "CREATE SEQUENCE components_sequential_number_seq START WITH 1 INCREMENT BY 1;"
    execute "CREATE SEQUENCE orders_sequential_number_seq START WITH 1 INCREMENT BY 1;"

    change_column_default :assemblies, :sku_number, -> { "nextval('assemblies_sequential_number_seq')" }
    change_column_default :components, :sku_number, -> { "nextval('components_sequential_number_seq')" }
    change_column_default :orders, :order_number, -> { "nextval('orders_sequential_number_seq')" }
  end
end
