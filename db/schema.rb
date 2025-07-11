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

ActiveRecord::Schema[8.0].define(version: 20_240_925_211_712) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index %w[record_type record_id name], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index %w[record_type record_id name blob_id], name: "index_active_storage_attachments_uniqueness",
                                                    unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index %w[blob_id variation_digest], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "citations", force: :cascade do |t|
    t.string "citable_type"
    t.integer "citable_id"
    t.text "text"
    t.json "attrs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edit_histories", force: :cascade do |t|
    t.string "action"
    t.string "editable_type"
    t.integer "editable_id"
    t.datetime "edited_at", precision: nil
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["editable_id"], name: "index_edit_histories_on_editable_id"
    t.index ["user_id"], name: "index_edit_histories_on_user_id"
  end

  create_table "facts", force: :cascade do |t|
    t.string "factable_type"
    t.integer "factable_id"
    t.string "fact_type"
    t.string "date_string"
    t.string "place"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "normalized_type"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.string "date_string"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "friendly_url"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "alternate_names"
    t.string "gender"
    t.integer "father_id"
    t.integer "mother_id"
    t.integer "current_spouse_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "bio"
    t.boolean "probably_alive"
    t.string "friendly_url"
    t.integer "birth_fact_id"
    t.integer "death_fact_id"
    t.integer "profile_photo_id"
    t.string "sex"
  end

  create_table "photos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "date_string"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "friendly_url"
  end

  create_table "search_documents", force: :cascade do |t|
    t.string "key"
    t.bigint "searchable_id"
    t.string "searchable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "privacy_scope", default: 0, null: false
    t.index ["key"], name: "index_search_documents_on_key"
    t.index %w[searchable_type searchable_id], name: "index_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.integer "thing_id"
    t.string "thing_type", limit: 30
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index %w[thing_type thing_id var], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true
  end

  create_table "snapshots", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil
    t.string "tenant", limit: 128
    t.index ["context"], name: "index_taggings_on_context"
    t.index %w[tag_id taggable_id taggable_type context tagger_id tagger_type], name: "taggings_idx",
                                                                                unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index %w[taggable_id taggable_type context],
            name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index %w[taggable_id taggable_type tagger_id context], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index %w[tagger_id tagger_type], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tenant"], name: "index_taggings_on_tenant"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.boolean "admin", default: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "edit_histories", "users"

  # Virtual tables defined in this database.
  # Note that virtual tables may not work with other database engines. Be careful if changing database.
  create_virtual_table "fts_search_documents", "fts5", %w[content key]
end
