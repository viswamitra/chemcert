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

ActiveRecord::Schema.define(version: 20131116155511) do

  create_table "course_process_details", force: true do |t|
    t.datetime "performa_received_at"
    t.datetime "course_received_at"
    t.string   "course_finish_time"
    t.string   "venue_rating"
    t.boolean  "t4_received"
    t.boolean  "declaration_form_signed"
    t.boolean  "enrolment_form_signed"
    t.string   "inhouse_client"
    t.float    "cash_received"
    t.string   "trainer_invoice_po"
    t.float    "trainer_payment_amount"
    t.string   "enrolment_center_invoice"
    t.boolean  "course_status"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: true do |t|
    t.integer  "training_organization_id", limit: 8, null: false
    t.boolean  "is_correspondence"
    t.string   "course_code"
    t.date     "course_date"
    t.integer  "location_relation_id",     limit: 8, null: false
    t.integer  "venue_id",                 limit: 8, null: false
    t.integer  "trainer_id",               limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["course_code"], name: "index_courses_on_course_code", unique: true, using: :btree

  create_table "demographies", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "location_relations", force: true do |t|
    t.integer  "town_id",        limit: 8, null: false
    t.integer  "state_id",       limit: 8, null: false
    t.integer  "postal_code_id", limit: 8, null: false
    t.boolean  "course_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "location_relations", ["town_id", "state_id", "postal_code_id"], name: "location_relation_index", unique: true, using: :btree

  create_table "locations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "postal_codes", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "special_needs", force: true do |t|
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_addresses", force: true do |t|
    t.integer  "student_id",                limit: 8, null: false
    t.string   "address"
    t.integer  "location_relation_id",      limit: 8, null: false
    t.string   "home_address"
    t.integer  "home_location_relation_id", limit: 8, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_biodata", force: true do |t|
    t.integer  "student_id",    limit: 8, null: false
    t.string   "gender"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.datetime "date_of_birth"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_course_detail_histories", force: true do |t|
    t.integer  "student_id",            limit: 8, null: false
    t.integer  "course_id",             limit: 8, null: false
    t.datetime "enrolled_at"
    t.string   "result"
    t.string   "special_modules"
    t.string   "comments"
    t.float    "course_fee"
    t.string   "payment_method"
    t.datetime "payment_date"
    t.boolean  "paid"
    t.boolean  "enquiry"
    t.string   "current_accreditation"
    t.datetime "current_expiry_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_course_details", force: true do |t|
    t.integer  "student_id",            limit: 8, null: false
    t.integer  "course_id",             limit: 8, null: false
    t.datetime "enrolled_at"
    t.string   "result"
    t.string   "special_modules"
    t.string   "comments"
    t.float    "course_fee"
    t.string   "payment_method"
    t.datetime "payment_date"
    t.boolean  "paid"
    t.boolean  "enquiry"
    t.string   "current_accreditation"
    t.datetime "current_expiry_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_courses", force: true do |t|
    t.string   "type"
    t.boolean  "weeds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_demographies", force: true do |t|
    t.integer  "student_id",              limit: 8, null: false
    t.integer  "demograhics_id",          limit: 8, null: false
    t.string   "hear_about_chemcert"
    t.string   "country_of_birth"
    t.string   "residency_status"
    t.string   "employment_status"
    t.string   "highest_education_level"
    t.string   "qualification_level"
    t.string   "study_reason"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_special_needs", force: true do |t|
    t.integer "student_id",      limit: 8, null: false
    t.integer "special_need_id", limit: 8, null: false
  end

  create_table "students", force: true do |t|
    t.string "student_id"
    t.string "usi_id"
  end

  add_index "students", ["student_id"], name: "index_students_on_student_id", unique: true, using: :btree

  create_table "towns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_organizations", force: true do |t|
    t.string   "name"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venue_contacts", force: true do |t|
    t.integer  "venue_id",   limit: 8, null: false
    t.string   "name"
    t.string   "phone"
    t.string   "fax"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "location_relation_id", limit: 8, null: false
    t.string   "room_name"
    t.float    "room_cost"
    t.string   "room_setup"
    t.integer  "capacity"
    t.integer  "screen"
    t.boolean  "whiteboard_available"
    t.string   "catering"
    t.boolean  "lunch_available"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
