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

ActiveRecord::Schema.define(version: 20170114083806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.float    "lat"
    t.float    "lng"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.integer  "country_id"
    t.integer  "province_id"
    t.integer  "city_id"
    t.integer  "district_id"
    t.string   "detail_address"
    t.integer  "sub_type",         default: 0
    t.integer  "address_type",     default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", using: :btree
    t.index ["city_id"], name: "index_addresses_on_city_id", using: :btree
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
    t.index ["district_id"], name: "index_addresses_on_district_id", using: :btree
    t.index ["lat", "lng"], name: "index_addresses_on_lat_and_lng", using: :btree
    t.index ["province_id"], name: "index_addresses_on_province_id", using: :btree
    t.index ["sub_type"], name: "index_addresses_on_sub_type", using: :btree
  end

  create_table "api_keys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_api_keys_on_user_id", using: :btree
  end

  create_table "app_versions", force: :cascade do |t|
    t.string   "name"
    t.integer  "app_type"
    t.string   "version_name"
    t.string   "version_code"
    t.string   "download_url"
    t.integer  "upgrade"
    t.text     "changelogs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "attachmentable_id"
    t.string   "attachmentable_type"
    t.string   "name"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "deleted_at"
    t.text     "note"
    t.string   "sub_type"
    t.integer  "attachment_position"
    t.string   "qiniu_persistent_id"
    t.datetime "updated_at",          null: false
    t.datetime "created_at",          null: false
    t.index ["attachmentable_id", "attachmentable_type"], name: "index_attachments_on_attachmentable_id_and_attachmentable_type", using: :btree
    t.index ["qiniu_persistent_id"], name: "index_attachments_on_qiniu_persistent_id", using: :btree
    t.index ["user_id"], name: "index_attachments_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "commodities_count", default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "pinyin"
    t.integer  "province_id"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_cities_on_name", using: :btree
    t.index ["pinyin"], name: "index_cities_on_pinyin", using: :btree
    t.index ["province_id"], name: "index_cities_on_province_id", using: :btree
  end

  create_table "commodities", force: :cascade do |t|
    t.string   "name"
    t.string   "no"
    t.string   "introduction"
    t.float    "price"
    t.integer  "category_id"
    t.integer  "stock",                                 comment: "库存"
    t.integer  "status",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["category_id"], name: "index_commodities_on_category_id", using: :btree
    t.index ["status"], name: "index_commodities_on_status", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.string   "pinyin"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_countries_on_name", using: :btree
    t.index ["pinyin"], name: "index_countries_on_pinyin", using: :btree
  end

  create_table "districts", force: :cascade do |t|
    t.string   "name"
    t.string   "pinyin"
    t.integer  "city_id"
    t.integer  "sort"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["city_id"], name: "index_districts_on_city_id", using: :btree
    t.index ["name"], name: "index_districts_on_name", using: :btree
    t.index ["pinyin"], name: "index_districts_on_pinyin", using: :btree
  end

  create_table "order_pays", force: :cascade do |t|
    t.string   "no"
    t.integer  "order_id"
    t.integer  "category"
    t.integer  "user_id"
    t.integer  "status",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["order_id"], name: "index_order_pays_on_order_id", using: :btree
    t.index ["status"], name: "index_order_pays_on_status", using: :btree
    t.index ["user_id"], name: "index_order_pays_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.string   "no"
    t.integer  "commodity_id"
    t.float    "origin_price"
    t.float    "discount"
    t.float    "price"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["commodity_id"], name: "index_orders_on_commodity_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "provinces", force: :cascade do |t|
    t.string   "name"
    t.string   "pinyin"
    t.integer  "sort"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["country_id"], name: "index_provinces_on_country_id", using: :btree
    t.index ["name"], name: "index_provinces_on_name", using: :btree
    t.index ["pinyin"], name: "index_provinces_on_pinyin", using: :btree
  end

  create_table "sms_codes", force: :cascade do |t|
    t.integer  "users_id"
    t.string   "phone"
    t.string   "code"
    t.integer  "sms_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone", "sms_type"], name: "index_sms_codes_on_phone_and_sms_type", using: :btree
    t.index ["phone"], name: "index_sms_codes_on_phone", using: :btree
    t.index ["users_id"], name: "index_sms_codes_on_users_id", using: :btree
  end

  create_table "user_accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "amount",        default: 0.0
    t.float    "total_amount",  default: 0.0
    t.float    "frozen_amount", default: 0.0
    t.integer  "status",        default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_user_accounts_on_user_id", using: :btree
  end

  create_table "user_devices", force: :cascade do |t|
    t.string   "uid"
    t.string   "device_token"
    t.string   "client_id"
    t.integer  "platform"
    t.integer  "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_user_devices_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "phone",                                            comment: "手机"
    t.string   "email",                  default: "",              comment: "邮箱"
    t.string   "name",                                             comment: "用户名"
    t.string   "surname",                                          comment: "姓"
    t.string   "name_pinyin"
    t.string   "authentication_token"
    t.datetime "activated"
    t.integer  "role",                   default: 0
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["phone"], name: "index_users_on_phone", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
