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

ActiveRecord::Schema[8.1].define(version: 2026_07_08_191116) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assemblies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.virtual "sku", type: :string, as: "(((sku_prefix)::text || '-'::text) || sku_number)", stored: true
    t.integer "sku_number", null: false
    t.string "sku_prefix", null: false
    t.string "status"
    t.string "tier"
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["sku_number"], name: "index_assemblies_on_sku_number", unique: true
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

  create_table "card_assemblies", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.datetime "created_at", null: false
    t.bigint "deck_id", null: false
    t.bigint "gift_assembly_id", null: false
    t.integer "position"
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_assemblies_on_card_id"
    t.index ["deck_id", "gift_assembly_id"], name: "index_card_assemblies_on_deck_and_gift_assembly", unique: true
    t.index ["deck_id"], name: "index_card_assemblies_on_deck_id"
    t.index ["gift_assembly_id"], name: "index_card_assemblies_on_gift_assembly_id"
  end

  create_table "cards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "deck_id", null: false
    t.string "name"
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
  end

  create_table "components", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.virtual "sku", type: :string, as: "(((sku_prefix)::text || '-'::text) || sku_number)", stored: true
    t.integer "sku_number", null: false
    t.string "sku_prefix", null: false
    t.string "status"
    t.string "type"
    t.integer "unit_of_measure"
    t.datetime "updated_at", null: false
    t.index ["sku_number"], name: "index_components_on_sku_number", unique: true
  end

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "status"
    t.string "tier"
    t.datetime "updated_at", null: false
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
    t.integer "order_number", null: false
    t.string "status"
    t.datetime "updated_at", null: false
    t.index ["order_number"], name: "index_orders_on_order_number", unique: true
  end

  create_table "restriction_names", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_restriction_names_on_name", unique: true
  end

  create_table "restrictions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "restrictable_id"
    t.string "restrictable_type"
    t.bigint "restriction_name_id", null: false
    t.datetime "updated_at", null: false
    t.index ["restriction_name_id"], name: "index_restrictions_on_restriction_name_id"
  end

  create_table "supplier_sku_components", force: :cascade do |t|
    t.bigint "component_id", null: false
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.bigint "supplier_sku_id", null: false
    t.datetime "updated_at", null: false
    t.index ["component_id"], name: "index_supplier_sku_components_on_component_id"
    t.index ["supplier_sku_id", "component_id"], name: "idx_on_supplier_sku_id_component_id_08bf377de2", unique: true
    t.index ["supplier_sku_id"], name: "index_supplier_sku_components_on_supplier_sku_id"
  end

  create_table "supplier_skus", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "sku"
    t.bigint "supplier_id", null: false
    t.datetime "updated_at", null: false
    t.integer "wholesale_cost_cents"
    t.virtual "wholesale_per_unit_cost_cents", type: :integer, as: "ceiling(((wholesale_cost_cents / wholesale_quantity))::double precision)", stored: true
    t.integer "wholesale_quantity"
    t.string "wholesale_url"
    t.index ["supplier_id"], name: "index_supplier_skus_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "account_status"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "lead_time"
    t.integer "min_order_dollars"
    t.integer "min_order_free_shipping"
    t.string "name"
    t.text "notes"
    t.string "sourcing_channel"
    t.datetime "updated_at", null: false
    t.string "website_url"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_assemblies", "assemblies", column: "gift_assembly_id"
  add_foreign_key "card_assemblies", "cards"
  add_foreign_key "card_assemblies", "decks"
  add_foreign_key "cards", "decks"
  add_foreign_key "restrictions", "restriction_names"
  add_foreign_key "supplier_sku_components", "components"
  add_foreign_key "supplier_sku_components", "supplier_skus"
  add_foreign_key "supplier_skus", "suppliers"
end
