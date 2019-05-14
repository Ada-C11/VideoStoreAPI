
ActiveRecord::Schema.define(version: 2019_05_14_192439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "phone"
    t.integer "movies_checked_out_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.date "release_date"
    t.integer "inventory"
    t.integer "available_inventory"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
