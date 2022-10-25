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

ActiveRecord::Schema[7.0].define(version: 2022_10_22_135732) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "auth_tokens", force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.integer "token_type"
    t.datetime "expire_at"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_auth_tokens_on_user_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.string "verb"
    t.string "path"
    t.string "code"
    t.integer "endpoint_type"
    t.jsonb "headers", default: {}
    t.jsonb "body", default: {}
    t.json "response", default: {}
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "path", "verb"], name: "index_endpoints_on_user_id_and_path_and_verb", unique: true
    t.index ["user_id"], name: "index_endpoints_on_user_id"
    t.index ["verb"], name: "index_endpoints_on_verb"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest", null: false
    t.string "password_reset_sent_at"
    t.string "encrypted_otp"
    t.integer "failed_attempts"
    t.boolean "verified"
    t.datetime "verfied_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "auth_tokens", "users"
  add_foreign_key "endpoints", "users"
end
