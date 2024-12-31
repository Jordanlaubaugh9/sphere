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

ActiveRecord::Schema[7.2].define(version: 2024_12_31_053536) do
  create_table "sphere_memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "sphere_id", null: false
    t.string "role"
    t.datetime "last_active_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sphere_id"], name: "index_sphere_memberships_on_sphere_id"
    t.index ["user_id"], name: "index_sphere_memberships_on_user_id"
  end

  create_table "spheres", force: :cascade do |t|
    t.integer "created_by_id", null: false
    t.string "name"
    t.string "slug"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_spheres_on_created_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "sphere_memberships", "spheres"
  add_foreign_key "sphere_memberships", "users"
  add_foreign_key "spheres", "users", column: "created_by_id"
end
