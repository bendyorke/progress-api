# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140517222716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_fields", force: true do |t|
    t.string   "name"
    t.string   "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "primary_muscle_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises_exercise_fields", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "exercise_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises_muscle_groups", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "muscle_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises_workouts", force: true do |t|
    t.integer  "workout_id"
    t.integer  "exercise_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "muscle_groups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "workouts", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end