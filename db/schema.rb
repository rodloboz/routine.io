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

ActiveRecord::Schema.define(version: 20170310094618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string   "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "routine_id"
    t.index ["routine_id"], name: "index_answers_on_routine_id", using: :btree
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.string   "secret"
    t.string   "profile_page"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_authorizations_on_user_id", using: :btree
  end

  create_table "fields", force: :cascade do |t|
    t.string   "name"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["answer_id"], name: "index_fields_on_answer_id", using: :btree
    t.index ["question_id"], name: "index_fields_on_question_id", using: :btree
  end

  create_table "question_choices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "question_id"
    t.index ["question_id"], name: "index_question_choices_on_question_id", using: :btree
  end

  create_table "question_types", force: :cascade do |t|
    t.string   "name"
    t.boolean  "require_question_choices"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "routine_id"
    t.integer  "question_type_id"
    t.integer  "position",         default: 0
    t.integer  "options"
    t.index ["question_type_id"], name: "index_questions_on_question_type_id", using: :btree
    t.index ["routine_id"], name: "index_questions_on_routine_id", using: :btree
  end

  create_table "routines", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.boolean  "template"
    t.boolean  "has_answer"
    t.index ["user_id"], name: "index_routines_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "picture"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "answers", "routines"
  add_foreign_key "authorizations", "users"
  add_foreign_key "fields", "answers"
  add_foreign_key "fields", "questions"
  add_foreign_key "question_choices", "questions"
  add_foreign_key "questions", "question_types"
  add_foreign_key "questions", "routines"
  add_foreign_key "routines", "users"
end
