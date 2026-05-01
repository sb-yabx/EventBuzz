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

ActiveRecord::Schema[8.1].define(version: 2026_04_30_084719) do
  create_table "activities", force: :cascade do |t|
    t.text "activity_description", null: false
    t.string "activity_name", null: false
    t.datetime "created_at", null: false
    t.integer "duration"
    t.integer "event_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["event_id", "duration"], name: "index_activities_on_event_id_and_duration"
    t.index ["event_id"], name: "index_activities_on_event_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "capacity", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.date "end_date"
    t.integer "event_manager_id"
    t.integer "guests_count"
    t.string "name", null: false
    t.datetime "start_date", null: false
    t.datetime "updated_at", null: false
    t.integer "venue_id", null: false
    t.index ["event_manager_id"], name: "index_events_on_event_manager_id"
    t.index ["start_date"], name: "index_events_on_start_date"
    t.index ["venue_id"], name: "index_events_on_venue_id"
  end

  create_table "guests", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.integer "event_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["event_id", "email"], name: "index_guests_on_event_id_and_email", unique: true
    t.index ["event_id"], name: "index_guests_on_event_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "queries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "event_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["event_id"], name: "index_queries_on_event_id"
    t.index ["user_id"], name: "index_queries_on_user_id"
  end

  create_table "query_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "message", null: false
    t.integer "query_id", null: false
    t.string "sender_type"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["query_id", "created_at"], name: "index_query_messages_on_query_id_and_created_at"
    t.index ["query_id"], name: "index_query_messages_on_query_id"
    t.index ["user_id"], name: "index_query_messages_on_user_id"
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
    t.index ["event_id", "status"], name: "index_rsvps_on_event_id_and_status"
    t.index ["event_id"], name: "index_rsvps_on_event_id"
    t.index ["user_id", "event_id"], name: "index_rsvps_on_user_id_and_event_id"
    t.index ["user_id"], name: "index_rsvps_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "venues", force: :cascade do |t|
    t.string "address", null: false
    t.integer "capacity", default: 0, null: false
    t.integer "contact"
    t.datetime "created_at", null: false
    t.string "facilities"
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "activities", "events"
  add_foreign_key "activities", "users"
  add_foreign_key "events", "users", column: "event_manager_id"
  add_foreign_key "events", "venues"
  add_foreign_key "guests", "events"
  add_foreign_key "guests", "users"
  add_foreign_key "queries", "events"
  add_foreign_key "queries", "users"
  add_foreign_key "query_messages", "queries"
  add_foreign_key "query_messages", "users"
  add_foreign_key "rsvps", "events"
  add_foreign_key "rsvps", "users"
end
