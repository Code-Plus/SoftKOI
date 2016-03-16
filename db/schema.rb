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

ActiveRecord::Schema.define(version: 20160316192136) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "state"
    t.integer  "type_product_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "categories", ["type_product_id"], name: "index_categories_on_type_product_id"

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

  add_index "customers", ["type_document_id"], name: "index_customers_on_type_document_id"

  create_table "input_products", force: :cascade do |t|
    t.integer  "stock",      default: 0
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "input_products", ["product_id"], name: "index_input_products_on_product_id"

  create_table "output_products", force: :cascade do |t|
    t.integer  "stock",      default: 0
    t.integer  "product_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "output_products", ["product_id"], name: "index_output_products_on_product_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price"
    t.string   "state"
    t.integer  "stock_min"
    t.integer  "stock",       default: 0
    t.integer  "category_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id"

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
  end

  add_index "users", ["document"], name: "index_users_on_document", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
