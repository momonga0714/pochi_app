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

ActiveRecord::Schema.define(version: 2020_05_19_235013) do

  create_table "mains", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "main_name"
    t.bigint "menu_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "genre_id", null: false
    t.integer "type_id", null: false
    t.bigint "user_id", null: false
    t.index ["menu_id"], name: "index_mains_on_menu_id"
    t.index ["user_id"], name: "index_mains_on_user_id"
  end

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resipi_images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image", null: false
    t.bigint "main_id"
    t.bigint "sub_id"
    t.bigint "soop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["main_id"], name: "index_resipi_images_on_main_id"
    t.index ["soop_id"], name: "index_resipi_images_on_soop_id"
    t.index ["sub_id"], name: "index_resipi_images_on_sub_id"
  end

  create_table "soops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "soop_name"
    t.bigint "menu_id"
    t.integer "genre_id", null: false
    t.integer "type_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["menu_id"], name: "index_soops_on_menu_id"
    t.index ["user_id"], name: "index_soops_on_user_id"
  end

  create_table "subs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "sub_name"
    t.bigint "menu_id"
    t.integer "genre_id", null: false
    t.integer "type_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["menu_id"], name: "index_subs_on_menu_id"
    t.index ["user_id"], name: "index_subs_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "mains", "menus"
  add_foreign_key "mains", "users"
  add_foreign_key "resipi_images", "mains"
  add_foreign_key "resipi_images", "soops"
  add_foreign_key "resipi_images", "subs"
  add_foreign_key "soops", "menus"
  add_foreign_key "soops", "users"
  add_foreign_key "subs", "menus"
  add_foreign_key "subs", "users"
end
