# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_03_30_183434) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "allocations", force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.uuid "denomination_id", null: false
    t.integer "count", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["denomination_id"], name: "index_allocations_on_denomination_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.jsonb "rp_data", default: {}, null: false
    t.uuid "denomination_id", null: false
    t.integer "count", null: false
    t.boolean "confirmed", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["denomination_id"], name: "index_bookings_on_denomination_id"
  end

  create_table "companies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_companies_on_url", unique: true
  end

  create_table "denominations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.uuid "performance_id", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["performance_id"], name: "index_denominations_on_performance_id"
  end

  create_table "performances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.uuid "show_id", null: false
    t.datetime "showtime", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["show_id"], name: "index_performances_on_show_id"
  end

  create_table "shows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", default: {}, null: false
    t.uuid "company_id", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id", "url"], name: "index_shows_on_company_id_and_url", unique: true
    t.index ["company_id"], name: "index_shows_on_company_id"
  end

  add_foreign_key "allocations", "denominations"
  add_foreign_key "bookings", "denominations"
  add_foreign_key "denominations", "performances"
  add_foreign_key "performances", "shows"
  add_foreign_key "shows", "companies"
end
