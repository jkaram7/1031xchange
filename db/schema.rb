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

ActiveRecord::Schema.define(version: 2022_03_03_215408) do

  create_table "acquisition_criteria", force: :cascade do |t|
    t.datetime "period_end_date"
    t.string "product_type"
    t.string "location"
    t.float "trade_size"
    t.integer "id_user"
    t.text "notes"
    t.boolean "active"
    t.integer "priority"
    t.float "cap_rate_min"
    t.float "cap_rate_max"
    t.string "property_sub_type"
    t.float "occupancy"
    t.string "return_profile"
    t.string "preferred_tenant"
    t.float "sq_feet"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text "content"
    t.boolean "read"
    t.integer "acquisition_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "company_name"
    t.string "phone_number"
    t.string "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "views", force: :cascade do |t|
    t.integer "id_acquisition"
    t.integer "id_viewer"
    t.boolean "clicked"
    t.boolean "potential_lead"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
