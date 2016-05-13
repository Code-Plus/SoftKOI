# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160513050728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "calendars", force: :cascade do |t|
    t.date     "date"
    t.text     "description"
    t.string   "title"
    t.time     "hour"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "calendars", ["user_id"], name: "index_calendars_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "state"
    t.integer  "type_product_id"
    t.date     "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "can_change",      default: true
  end

  add_index "categories", ["type_product_id"], name: "index_categories_on_type_product_id", using: :btree

  create_table "consoles", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "serial"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "document"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "cellphone"
    t.date     "birthday"
    t.string   "email"
    t.string   "state"
    t.integer  "type_document_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "customers", ["type_document_id"], name: "index_customers_on_type_document_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "description"
    t.datetime "start_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
  end

  create_table "input_products", force: :cascade do |t|
    t.integer  "stock",      default: 0
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "input_products", ["product_id"], name: "index_input_products_on_product_id", using: :btree

  create_table "item_coupons", force: :cascade do |t|
    t.integer  "sale_id"
    t.integer  "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "item_coupons", ["coupon_id"], name: "index_item_coupons_on_coupon_id", using: :btree
  add_index "item_coupons", ["sale_id"], name: "index_item_coupons_on_sale_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "sale_id"
    t.integer  "quantity",    default: 1
    t.integer  "price",       default: 0
    t.integer  "total_price", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "items", ["product_id"], name: "index_items_on_product_id", using: :btree
  add_index "items", ["sale_id"], name: "index_items_on_sale_id", using: :btree

  create_table "output_products", force: :cascade do |t|
    t.integer  "stock",      default: 0
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "output_products", ["product_id"], name: "index_output_products_on_product_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "amount",     default: 0
    t.integer  "sale_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "payments", ["sale_id"], name: "index_payments_on_sale_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "state"
    t.integer  "stock_min"
    t.integer  "stock",       default: 0
    t.integer  "category_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "can_change",  default: true
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree

  create_table "reservations", force: :cascade do |t|
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "state"
    t.string   "customer"
    t.integer  "reserve_price_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "reservations", ["reserve_price_id"], name: "index_reservations_on_reserve_price_id", using: :btree

  create_table "reserve_prices", force: :cascade do |t|
    t.integer  "value"
    t.integer  "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "console_id"
  end

  add_index "reserve_prices", ["console_id"], name: "index_reserve_prices_on_console_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.string   "state"
    t.integer  "amount",       default: 0
    t.integer  "total_amount", default: 0
    t.integer  "discount",     default: 0
    t.date     "limit_date",   default: '2016-05-10'
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "customer_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "sales", ["customer_id"], name: "index_sales_on_customer_id", using: :btree
  add_index "sales", ["user_id"], name: "index_sales_on_user_id", using: :btree

  create_table "type_documents", force: :cascade do |t|
    t.string "description", null: false
  end

  create_table "type_products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "document",               default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "phone"
    t.string   "cellphone"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.boolean  "can_inventory"
    t.boolean  "can_sales"
    t.boolean  "can_changes"
    t.boolean  "can_consoles"
    t.boolean  "can_customers"
    t.string   "state"
    t.integer  "type_document_id"
  end

  add_index "users", ["document"], name: "index_users_on_document", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["type_document_id"], name: "index_users_on_type_document_id", using: :btree

  add_foreign_key "calendars", "users"
  add_foreign_key "categories", "type_products"
  add_foreign_key "customers", "type_documents"
  add_foreign_key "input_products", "products"
  add_foreign_key "item_coupons", "coupons"
  add_foreign_key "item_coupons", "sales"
  add_foreign_key "items", "products"
  add_foreign_key "items", "sales"
  add_foreign_key "output_products", "products"
  add_foreign_key "payments", "sales"
  add_foreign_key "products", "categories"
  add_foreign_key "reservations", "reserve_prices"
  add_foreign_key "reserve_prices", "consoles"
  add_foreign_key "sales", "customers"
  add_foreign_key "sales", "users"
  add_foreign_key "users", "type_documents"
end
