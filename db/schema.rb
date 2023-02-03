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

ActiveRecord::Schema[7.0].define(version: 2023_02_03_073222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "listing_condition", ["mint", "near_mint", "used", "defective"]
  create_enum "listing_status", ["draft", "published", "expired"]

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "line_1"
    t.string "line_2"
    t.string "city"
    t.string "country"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "latitude"
    t.decimal "longitude"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
    t.index ["latitude", "longitude"], name: "index_addresses_on_latitude_and_longitude"
  end

  create_table "app_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_app_sessions_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "listing_id"
    t.bigint "seller_id"
    t.bigint "buyer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_conversations_on_buyer_id"
    t.index ["listing_id"], name: "index_conversations_on_listing_id"
    t.index ["seller_id", "buyer_id", "listing_id"], name: "index_conversations_on_seller_id_and_buyer_id_and_listing_id", unique: true
    t.index ["seller_id"], name: "index_conversations_on_seller_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.integer "price"
    t.bigint "organization_id", null: false
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.enum "condition", enum_type: "listing_condition"
    t.string "tags", array: true
    t.enum "status", default: "published", enum_type: "listing_status"
    t.datetime "published_on"
    t.virtual "searchable", type: :tsvector, as: "to_tsvector('english'::regconfig, (COALESCE(title, ''::character varying))::text)", stored: true
    t.index ["creator_id"], name: "index_listings_on_creator_id"
    t.index ["organization_id"], name: "index_listings_on_organization_id"
    t.index ["searchable"], name: "index_listings_on_searchable", using: :gin
    t.index ["tags"], name: "index_listings_on_tags", using: :gin
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_memberships_on_organization_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "from_id"
    t.bigint "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["from_id"], name: "index_messages_on_from_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_listings", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "listing_id", null: false
    t.index ["user_id", "listing_id"], name: "index_saved_listings_on_user_id_and_listing_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_reset_token_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "app_sessions", "users"
  add_foreign_key "conversations", "listings", on_delete: :cascade
  add_foreign_key "conversations", "organizations", column: "buyer_id"
  add_foreign_key "conversations", "organizations", column: "seller_id"
  add_foreign_key "listings", "organizations"
  add_foreign_key "listings", "users", column: "creator_id"
  add_foreign_key "memberships", "organizations"
  add_foreign_key "memberships", "users"
  add_foreign_key "messages", "conversations", on_delete: :cascade
  add_foreign_key "messages", "organizations", column: "from_id"
  add_foreign_key "messages", "users", column: "sender_id", on_delete: :nullify
  add_foreign_key "saved_listings", "listings", on_delete: :cascade
  add_foreign_key "saved_listings", "users", on_delete: :cascade
end
