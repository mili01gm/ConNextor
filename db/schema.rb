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

ActiveRecord::Schema.define(version: 20150323105812) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "interests", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profile_contacts", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "contact_type"
    t.string   "name"
    t.string   "link"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "profile_experiences", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "name"
    t.string   "position"
    t.string   "from_date"
    t.string   "to_date"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "profile_introductions", force: :cascade do |t|
    t.integer  "profile_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "location"
    t.string   "school"
    t.string   "short_bio"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "linkedin_url"
  end

  create_table "project_tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "project_tasks", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "state"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "project_to_tags", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "project_tag_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.string   "short_description"
    t.string   "long_description"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_project_follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_to_interests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "user_to_interests", ["interest_id"], name: "index_user_to_interests_on_interest_id", using: :btree
  add_index "user_to_interests", ["user_id"], name: "index_user_to_interests_on_user_id", using: :btree

  create_table "user_to_project_tasks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_task_id"
    t.string   "relation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "user_to_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "project_user_class"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "user_to_skills", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_to_skills", ["skill_id"], name: "index_user_to_skills_on_skill_id", using: :btree
  add_index "user_to_skills", ["user_id"], name: "index_user_to_skills_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "auth_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "remember_token"
    t.string   "image"
    t.integer  "profile_id"
    t.boolean  "password_login"
  end

  add_foreign_key "user_to_interests", "interests"
  add_foreign_key "user_to_interests", "users"
  add_foreign_key "user_to_skills", "skills"
  add_foreign_key "user_to_skills", "users"
end
