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

ActiveRecord::Schema[7.2].define(version: 2025_03_14_072447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_tickets", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "booking_id", null: false
    t.bigint "ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_tickets_on_booking_id"
    t.index ["ticket_id"], name: "index_booking_tickets_on_ticket_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "booking_date"
    t.decimal "total_price"
    t.string "status"
    t.bigint "customer_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["event_id"], name: "index_bookings_on_event_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.text "address"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email"
  end

  create_table "event_organizers", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.text "description"
    t.string "contact_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_event_organizers_on_email"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.string "venue"
    t.integer "capacity"
    t.bigint "event_organizer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_organizer_id"], name: "index_events_on_event_organizer_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "category"
    t.decimal "price"
    t.integer "quantity"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_tickets_on_event_id"
  end

  add_foreign_key "booking_tickets", "bookings"
  add_foreign_key "booking_tickets", "tickets"
  add_foreign_key "bookings", "customers"
  add_foreign_key "bookings", "events"
  add_foreign_key "events", "event_organizers"
  add_foreign_key "tickets", "events"
end
