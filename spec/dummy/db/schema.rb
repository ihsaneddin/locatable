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

ActiveRecord::Schema[7.0].define(version: 2025_06_26_132458) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "locatable_location_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
  end

  create_table "locatable_locations", force: :cascade do |t|
    t.bigint "parent_id"
    t.string "locatable_type"
    t.bigint "locatable_id"
    t.string "name"
    t.string "label"
    t.string "context"
    t.string "slug"
    t.string "unit"
    t.string "building_name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "postcode"
    t.string "country"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "full_address"
    t.datetime "deleted_at"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locatable_type", "locatable_id"], name: "index_locatable_locations_on_locatable"
    t.index ["parent_id"], name: "index_locatable_locations_on_parent_id"
    t.index ["slug"], name: "index_locatable_locations_on_slug"
  end

  create_table "locatable_locators", force: :cascade do |t|
    t.bigint "location_id"
    t.string "locatable_type"
    t.bigint "locatable_id"
    t.string "context"
    t.string "type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["locatable_type", "locatable_id"], name: "index_locatable_locators_on_locatable"
    t.index ["location_id"], name: "index_locatable_locators_on_location_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "contact_number"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
