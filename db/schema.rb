# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_02_063712) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "assemblies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.virtual "sku", type: :string, as: "(((sku_prefix)::text || '-'::text) || sku_number)", stored: true
    t.integer "sku_number", default: -> { "nextval('assemblies_sequential_number_seq'::regclass)" }, null: false
    t.string "sku_prefix", null: false
    t.string "status"
    t.bigint "subcategory_id"
    t.string "tier"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["sku_number"], name: "index_assemblies_on_sku_number", unique: true
    t.index ["subcategory_id"], name: "index_assemblies_on_subcategory_id"
  end

  create_table "assembly_line_items", force: :cascade do |t|
    t.bigint "assembly_id"
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.integer "sequence"
    t.datetime "updated_at", null: false
    t.index ["assembly_id"], name: "index_assembly_line_items_on_assembly_id"
  end

  create_table "boxes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "order_id"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_boxes_on_order_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.virtual "sku", type: :string, as: "(((sku_prefix)::text || '-'::text) || sku_number)", stored: true
    t.integer "sku_number", default: -> { "nextval('components_sequential_number_seq'::regclass)" }, null: false
    t.string "sku_prefix", null: false
    t.string "status"
    t.bigint "subcategory_id"
    t.string "tier"
    t.string "type"
    t.integer "unit_of_measure"
    t.datetime "updated_at", null: false
    t.index ["sku_number"], name: "index_components_on_sku_number", unique: true
    t.index ["subcategory_id"], name: "index_components_on_subcategory_id"
  end

  create_table "line_item_options", force: :cascade do |t|
    t.bigint "assembly_line_item_id"
    t.datetime "created_at", null: false
    t.boolean "is_primary"
    t.bigint "option_id"
    t.string "option_type"
    t.datetime "updated_at", null: false
    t.index ["assembly_line_item_id"], name: "index_line_item_options_on_assembly_line_item_id"
    t.index ["option_type", "option_id"], name: "index_line_item_options_on_option"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "order_number", default: -> { "nextval('orders_sequential_number_seq'::regclass)" }, null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
  end

  create_table "restrictions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "restrictable_id"
    t.string "restrictable_type"
    t.datetime "updated_at", null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "supplier_skus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "msrp_cents"
    t.string "msrp_url"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "wholesale_cost_cents"
    t.virtual "wholesale_per_unit_cost_cents", type: :integer, as: "ceiling(((wholesale_cost_cents / wholesale_quantity))::double precision)", stored: true
    t.integer "wholesale_quantity"
    t.string "wholesale_url"
  end

  create_table "suppliers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "type"
    t.datetime "updated_at", null: false
  end
end
