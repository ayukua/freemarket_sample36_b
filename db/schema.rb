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

ActiveRecord::Schema.define(version: 20190503112953) do

  create_table "cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",     null: false
    t.string   "customer_id", null: false
    t.string   "card_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_cards_on_user_id", using: :btree
  end

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "ancestry"
    t.index ["ancestry"], name: "index_categories_on_ancestry", using: :btree
  end

  create_table "images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "image",      limit: 65535
    t.integer  "item_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["item_id"], name: "fk_rails_63c410e8ba", using: :btree
  end

  create_table "item_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "item_id",     null: false
    t.integer  "categoty_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["categoty_id"], name: "index_item_categories_on_categoty_id", using: :btree
    t.index ["item_id"], name: "index_item_categories_on_item_id", using: :btree
  end

  create_table "prefectures", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                 null: false
    t.text     "introduce",              limit: 65535, null: false
    t.integer  "condition",                            null: false
    t.integer  "delivery_fee_payer",                   null: false
    t.integer  "shipping_method",                      null: false
    t.integer  "area",                                 null: false
    t.integer  "days_to_delivery",                     null: false
    t.integer  "price",                                null: false
    t.integer  "seller_id",                            null: false
    t.integer  "parent_category_id",                   null: false
    t.integer  "child_category_id",                    null: false
    t.integer  "grandchild_category_id",               null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["child_category_id"], name: "index_products_on_child_category_id", using: :btree
    t.index ["grandchild_category_id"], name: "index_products_on_grandchild_category_id", using: :btree
    t.index ["parent_category_id"], name: "index_products_on_parent_category_id", using: :btree
    t.index ["seller_id"], name: "index_products_on_seller_id", using: :btree
  end

  create_table "sns_credentials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sns_credentials_on_user_id", using: :btree
  end

  create_table "statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "stage",      null: false
    t.integer  "item_id",    null: false
    t.integer  "buyer_id",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buyer_id"], name: "index_statuses_on_buyer_id", using: :btree
    t.index ["item_id"], name: "index_statuses_on_item_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                                default: "", null: false
    t.string   "encrypted_password",                   default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "nickname",                                          null: false
    t.string   "family_name",                                       null: false
    t.string   "first_name",                                        null: false
    t.string   "kana_family_name",                                  null: false
    t.string   "kana_first_name",                                   null: false
    t.integer  "birth_year",                                        null: false
    t.integer  "birth_month",                                       null: false
    t.integer  "birth_day",                                         null: false
    t.string   "postal_code",                                       null: false
    t.string   "prefecture",                                        null: false
    t.string   "city",                                              null: false
    t.integer  "block_number",                                      null: false
    t.string   "building_name"
    t.string   "tel"
    t.string   "profil_image"
    t.text     "profil_comment",         limit: 65535
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "images", "products", column: "item_id"
  add_foreign_key "item_categories", "products", column: "item_id"
  add_foreign_key "products", "categories", column: "child_category_id"
  add_foreign_key "products", "categories", column: "grandchild_category_id"
  add_foreign_key "products", "categories", column: "parent_category_id"
  add_foreign_key "products", "users", column: "seller_id"
  add_foreign_key "sns_credentials", "users"
  add_foreign_key "statuses", "products", column: "item_id"
end
