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

ActiveRecord::Schema[8.1].define(version: 2026_03_23_063314) do
  create_table "activities", force: :cascade do |t|
    t.text "activity_description", null: false
    t.string "activity_name", null: false
    t.datetime "created_at", null: false
    t.datetime "end_time", null: false
    t.integer "event_id", null: false
    t.datetime "start_time", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["event_id"], name: "index_activities_on_event_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "date"
    t.text "description"
    t.datetime "end_time", null: false
    t.integer "event_manager_id"
    t.string "name", null: false
    t.datetime "start_time", null: false
    t.datetime "updated_at", null: false
    t.integer "venue_id", null: false
    t.index ["event_manager_id"], name: "index_events_on_event_manager_id"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.integer "event_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["event_id"], name: "index_guests_on_event_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "rsvps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "dietary_preference"
    t.integer "event_id", null: false
    t.boolean "need_accommodation"
    t.boolean "need_parking"
    t.string "seating_preference"
    t.text "special_request"
    t.string "status", default: "Pending"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["event_id"], name: "index_rsvps_on_event_id"
    t.index ["user_id"], name: "index_rsvps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "address", null: false
    t.integer "capacity", default: 0, null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "events"
  add_foreign_key "activities", "users"
  add_foreign_key "events", "users", column: "event_manager_id"
  add_foreign_key "events", "venues"
  add_foreign_key "guests", "events"
  add_foreign_key "guests", "users"
  add_foreign_key "rsvps", "events"
  add_foreign_key "rsvps", "users"
end
