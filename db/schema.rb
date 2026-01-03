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

ActiveRecord::Schema[8.0].define(version: 2026_01_02_000000) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "life_stage", ["Baby", "Adult"]

  create_table "habit_logs", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "habit_id"
    t.bigint "profile_id"
    t.date "log_date"
    t.text "notes"
    t.jsonb "extra_data"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
  end

  create_table "habits", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "profile_id"
    t.string "name"
    t.text "description"
    t.string "category"
  end

  create_table "milestones", force: :cascade do |t|
    t.bigint "profile_id", null: false
    t.string "title", null: false
    t.string "category"
    t.datetime "occurred_at", null: false
    t.string "mood"
    t.text "notes"
    t.text "tags"
    t.boolean "favorite", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["occurred_at"], name: "index_milestones_on_occurred_at"
    t.index ["profile_id", "category"], name: "index_milestones_on_profile_id_and_category"
    t.index ["profile_id", "favorite"], name: "index_milestones_on_profile_id_and_favorite"
    t.index ["profile_id"], name: "index_milestones_on_profile_id"
  end

  create_table "profiles", id: :bigint, default: -> { "nextval('users_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "user_id"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.enum "profile_type", enum_type: "life_stage"
    t.check_constraint "dob <= CURRENT_DATE", name: "check_dob"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "email"
    t.string "phone_number"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.unique_constraint ["email"], name: "users_email_key"
    t.unique_constraint ["user_name"], name: "users_user_name_key"
  end

  add_foreign_key "habit_logs", "habits", name: "habits_logs_habit_id_fkey"
  add_foreign_key "habit_logs", "profiles", name: "habits_logs_profile_id_fkey"
  add_foreign_key "habits", "profiles", name: "habits_profile_id_fkey"
  add_foreign_key "milestones", "profiles"
  add_foreign_key "profiles", "users", name: "profiles_user_id_fkey"
end
