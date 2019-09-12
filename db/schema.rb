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

ActiveRecord::Schema.define(version: 2019_09_12_095350) do

  create_table "children", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.float "age"
    t.string "gender"
    t.float "ambition"
    t.float "happiness"
    t.float "social"
    t.float "art"
    t.float "coding"
    t.float "language"
    t.float "mathematic"
    t.integer "job_id"
    t.integer "personality_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "temp_job_id"
    t.index ["job_id"], name: "index_children_on_job_id"
    t.index ["personality_id"], name: "index_children_on_personality_id"
    t.index ["user_id"], name: "index_children_on_user_id"
  end

  create_table "hobbies", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.float "happiness"
    t.float "ambition"
    t.float "language"
    t.float "mathematic"
    t.float "coding"
    t.float "art"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "learnings", force: :cascade do |t|
    t.string "action"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "main_children", force: :cascade do |t|
    t.integer "child_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["child_id"], name: "index_main_children_on_child_id"
    t.index ["user_id"], name: "index_main_children_on_user_id"
  end

  create_table "personalities", force: :cascade do |t|
    t.integer "child_id"
    t.string "social_trait"
    t.string "learning_trait"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "learning_id"
    t.integer "hobby_id"
    t.index ["child_id"], name: "index_personalities_on_child_id"
  end

  create_table "socializations", force: :cascade do |t|
    t.string "action"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "main_children", "children"
  add_foreign_key "main_children", "users"
end
