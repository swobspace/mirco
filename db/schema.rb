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

ActiveRecord::Schema.define(version: 2021_11_21_102731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "timescaledb"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.bigint "channel_id", null: false
    t.string "type"
    t.text "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_alerts_on_channel_id"
    t.index ["server_id"], name: "index_alerts_on_server_id"
    t.index ["type"], name: "index_alerts_on_type"
  end

  create_table "channel_counters", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "server_id", null: false
    t.integer "received"
    t.integer "sent"
    t.integer "error"
    t.integer "filtered"
    t.integer "queued"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "meta_data_id"
    t.bigint "channel_statistic_id", null: false
    t.index ["channel_id"], name: "index_channel_counters_on_channel_id"
    t.index ["channel_statistic_id"], name: "index_channel_counters_on_channel_statistic_id"
    t.index ["created_at"], name: "channel_counters_created_at_idx", order: :desc
    t.index ["server_id"], name: "index_channel_counters_on_server_id"
  end

  create_table "channel_statistics", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.bigint "channel_id", null: false
    t.string "server_uid", null: false
    t.string "channel_uid", null: false
    t.integer "received", default: 0
    t.integer "sent", default: 0
    t.integer "error", default: 0
    t.integer "filtered", default: 0
    t.integer "queued", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "meta_data_id"
    t.string "name", default: ""
    t.string "state", default: ""
    t.string "status_type", default: ""
    t.index ["channel_id", "meta_data_id"], name: "index_channel_statistics_on_channel_id_and_meta_data_id", unique: true
    t.index ["channel_uid"], name: "index_channel_statistics_on_channel_uid"
    t.index ["server_id"], name: "index_channel_statistics_on_server_id"
    t.index ["server_uid"], name: "index_channel_statistics_on_server_uid"
  end

  create_table "channels", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.string "uid", null: false
    t.jsonb "properties"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["server_id"], name: "index_channels_on_server_id"
    t.index ["uid"], name: "index_channels_on_uid"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.string "cron"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "server_id", null: false
    t.bigint "channel_id"
    t.bigint "user_id", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_notes_on_channel_id"
    t.index ["server_id"], name: "index_notes_on_server_id"
    t.index ["type"], name: "index_notes_on_type"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "uid", default: ""
    t.string "location", default: ""
    t.text "description"
    t.string "api_url", default: ""
    t.string "api_user", default: ""
    t.text "api_password_ciphertext"
    t.boolean "api_user_has_full_access", default: true
    t.jsonb "properties"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "api_verify_ssl", default: false
    t.datetime "last_channel_update"
    t.datetime "last_check"
    t.datetime "last_check_ok"
    t.index ["uid"], name: "index_servers_on_uid"
  end

  create_table "wobauth_authorities", force: :cascade do |t|
    t.bigint "authorizable_id"
    t.string "authorizable_type"
    t.bigint "role_id"
    t.bigint "authorized_for_id"
    t.string "authorized_for_type"
    t.date "valid_from"
    t.date "valid_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["authorizable_id"], name: "index_wobauth_authorities_on_authorizable_id"
    t.index ["authorized_for_id"], name: "index_wobauth_authorities_on_authorized_for_id"
    t.index ["role_id"], name: "index_wobauth_authorities_on_role_id"
  end

  create_table "wobauth_groups", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_memberships", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.boolean "auto", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_wobauth_memberships_on_group_id"
    t.index ["user_id"], name: "index_wobauth_memberships_on_user_id"
  end

  create_table "wobauth_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wobauth_users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.text "gruppen"
    t.string "sn"
    t.string "givenname"
    t.string "displayname"
    t.string "telephone"
    t.string "active_directory_guid"
    t.string "userprincipalname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", default: ""
    t.string "position", default: ""
    t.string "department", default: ""
    t.string "company", default: ""
    t.index ["reset_password_token"], name: "index_wobauth_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_wobauth_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alerts", "channels"
  add_foreign_key "alerts", "servers"
  add_foreign_key "channel_statistics", "channels"
  add_foreign_key "channel_statistics", "servers"
  add_foreign_key "channels", "servers"
  add_foreign_key "notes", "servers"
  add_foreign_key "notes", "wobauth_users", column: "user_id"
end
