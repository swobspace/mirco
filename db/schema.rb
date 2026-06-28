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

ActiveRecord::Schema[8.1].define(version: 2026_06_28_112819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"
  enable_extension "timescaledb"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "alerts", force: :cascade do |t|
    t.bigint "channel_id"
    t.bigint "channel_statistic_id"
    t.datetime "created_at", null: false
    t.text "message"
    t.bigint "server_id", null: false
    t.string "type"
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_alerts_on_channel_id"
    t.index ["channel_statistic_id"], name: "index_alerts_on_channel_statistic_id"
    t.index ["server_id"], name: "index_alerts_on_server_id"
    t.index ["type"], name: "index_alerts_on_type"
  end

  create_table "channel_counters", id: false, force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.bigint "channel_statistic_id", null: false
    t.datetime "created_at", null: false
    t.integer "error"
    t.integer "filtered"
    t.integer "meta_data_id"
    t.integer "queued"
    t.integer "received"
    t.integer "sent"
    t.bigint "server_id", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_counters_on_channel_id"
    t.index ["channel_statistic_id"], name: "index_channel_counters_on_channel_statistic_id"
    t.index ["created_at"], name: "channel_counters_created_at_idx", order: :desc
    t.index ["server_id"], name: "index_channel_counters_on_server_id"
  end

  create_table "channel_statistic_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", default: ""
    t.datetime "updated_at", null: false
  end

  create_table "channel_statistic_groups_statistics", id: false, force: :cascade do |t|
    t.bigint "channel_statistic_group_id", null: false
    t.bigint "channel_statistic_id", null: false
    t.index ["channel_statistic_group_id", "channel_statistic_id"], name: "idx_statisticsgroup_statistic"
    t.index ["channel_statistic_id", "channel_statistic_group_id"], name: "idx_statistic_statisticsgroup"
  end

  create_table "channel_statistics", force: :cascade do |t|
    t.bigint "acknowledge_id"
    t.bigint "channel_id", null: false
    t.string "channel_uid", null: false
    t.integer "condition", default: -1
    t.string "condition_message", default: ""
    t.datetime "created_at", null: false
    t.integer "error", default: 0
    t.integer "filtered", default: 0
    t.datetime "last_condition_change", precision: nil
    t.datetime "last_message_error_at", precision: nil
    t.datetime "last_message_received_at", precision: nil
    t.datetime "last_message_sent_at", precision: nil
    t.integer "meta_data_id"
    t.string "name", default: ""
    t.bigint "old_current_note_id"
    t.string "oldcondition", default: ""
    t.integer "queued", default: 0
    t.integer "received", default: 0
    t.integer "sent", default: 0
    t.bigint "server_id", null: false
    t.string "server_uid", null: false
    t.string "state", default: ""
    t.string "status_type", default: ""
    t.datetime "updated_at", null: false
    t.index ["channel_id", "meta_data_id"], name: "index_channel_statistics_on_channel_id_and_meta_data_id", unique: true
    t.index ["channel_uid"], name: "index_channel_statistics_on_channel_uid"
    t.index ["condition"], name: "index_channel_statistics_on_condition"
    t.index ["old_current_note_id"], name: "index_channel_statistics_on_old_current_note_id"
    t.index ["oldcondition"], name: "index_channel_statistics_on_oldcondition"
    t.index ["server_id"], name: "index_channel_statistics_on_server_id"
    t.index ["server_uid"], name: "index_channel_statistics_on_server_uid"
  end

  create_table "channels", force: :cascade do |t|
    t.bigint "acknowledge_id"
    t.integer "condition", default: 0
    t.string "condition_message", default: ""
    t.datetime "created_at", null: false
    t.boolean "enabled", default: true
    t.jsonb "properties"
    t.bigint "server_id", null: false
    t.string "state", default: ""
    t.string "uid", null: false
    t.datetime "updated_at", null: false
    t.index ["condition"], name: "index_channels_on_condition"
    t.index ["server_id"], name: "index_channels_on_server_id"
    t.index ["uid"], name: "index_channels_on_uid"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at"
    t.string "cron"
    t.datetime "failed_at", precision: nil
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at", precision: nil
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at", precision: nil
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "escalation_levels", force: :cascade do |t|
    t.string "attrib", null: false
    t.datetime "created_at", null: false
    t.bigint "escalatable_id", null: false
    t.string "escalatable_type", null: false
    t.integer "max_critical"
    t.integer "max_warning"
    t.integer "min_critical"
    t.integer "min_warning"
    t.bigint "notification_group_id"
    t.boolean "show_on_dashboard", default: false
    t.datetime "updated_at", null: false
    t.index ["attrib"], name: "index_escalation_levels_on_attrib"
    t.index ["escalatable_type", "escalatable_id"], name: "index_escalation_levels_on_escalatable"
    t.index ["notification_group_id"], name: "index_escalation_levels_on_notification_group_id"
    t.index ["show_on_dashboard"], name: "index_escalation_levels_on_show_on_dashboard"
  end

  create_table "escalation_times", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "end_time", limit: 5, default: "23:59"
    t.bigint "escalation_level_id", null: false
    t.string "start_time", limit: 5, default: "00:00"
    t.datetime "updated_at", null: false
    t.integer "weekdays", array: true
    t.index ["escalation_level_id"], name: "index_escalation_times_on_escalation_level_id"
  end

  create_table "good_job_batches", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "callback_priority"
    t.text "callback_queue_name"
    t.datetime "created_at", null: false
    t.text "description"
    t.datetime "discarded_at"
    t.datetime "enqueued_at"
    t.datetime "finished_at"
    t.datetime "jobs_finished_at"
    t.text "on_discard"
    t.text "on_finish"
    t.text "on_success"
    t.jsonb "serialized_properties"
    t.datetime "updated_at", null: false
  end

  create_table "good_job_executions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "active_job_id", null: false
    t.datetime "created_at", null: false
    t.interval "duration"
    t.text "error"
    t.text "error_backtrace", array: true
    t.integer "error_event", limit: 2
    t.datetime "finished_at"
    t.text "job_class"
    t.uuid "process_id"
    t.text "queue_name"
    t.datetime "scheduled_at"
    t.jsonb "serialized_params"
    t.datetime "updated_at", null: false
    t.index ["active_job_id", "created_at"], name: "index_good_job_executions_on_active_job_id_and_created_at"
    t.index ["process_id", "created_at"], name: "index_good_job_executions_on_process_id_and_created_at"
  end

  create_table "good_job_processes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "lock_type", limit: 2
    t.jsonb "state"
    t.datetime "updated_at", null: false
  end

  create_table "good_job_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "key"
    t.datetime "updated_at", null: false
    t.jsonb "value"
    t.index ["key"], name: "index_good_job_settings_on_key", unique: true
  end

  create_table "good_jobs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "active_job_id"
    t.uuid "batch_callback_id"
    t.uuid "batch_id"
    t.text "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "cron_at"
    t.text "cron_key"
    t.text "error"
    t.integer "error_event", limit: 2
    t.integer "executions_count"
    t.datetime "finished_at"
    t.boolean "is_discrete"
    t.text "job_class"
    t.text "labels", array: true
    t.integer "lock_type", limit: 2
    t.datetime "locked_at"
    t.uuid "locked_by_id"
    t.datetime "performed_at"
    t.integer "priority"
    t.text "queue_name"
    t.uuid "retried_good_job_id"
    t.datetime "scheduled_at"
    t.jsonb "serialized_params"
    t.datetime "updated_at", null: false
    t.index ["active_job_id", "created_at"], name: "index_good_jobs_on_active_job_id_and_created_at"
    t.index ["batch_callback_id"], name: "index_good_jobs_on_batch_callback_id", where: "(batch_callback_id IS NOT NULL)"
    t.index ["batch_id"], name: "index_good_jobs_on_batch_id", where: "(batch_id IS NOT NULL)"
    t.index ["concurrency_key", "created_at"], name: "index_good_jobs_on_concurrency_key_and_created_at"
    t.index ["concurrency_key"], name: "index_good_jobs_on_concurrency_key_when_unfinished", where: "(finished_at IS NULL)"
    t.index ["created_at"], name: "index_good_jobs_on_created_at"
    t.index ["cron_key", "created_at"], name: "index_good_jobs_on_cron_key_and_created_at_cond", where: "(cron_key IS NOT NULL)"
    t.index ["cron_key", "cron_at"], name: "index_good_jobs_on_cron_key_and_cron_at_cond", unique: true, where: "(cron_key IS NOT NULL)"
    t.index ["finished_at"], name: "index_good_jobs_jobs_on_finished_at_only", where: "(finished_at IS NOT NULL)"
    t.index ["finished_at"], name: "index_good_jobs_on_discarded", order: :desc, where: "((finished_at IS NOT NULL) AND (error IS NOT NULL))"
    t.index ["id"], name: "index_good_jobs_on_unfinished_or_errored", where: "((finished_at IS NULL) OR (error IS NOT NULL))"
    t.index ["job_class"], name: "index_good_jobs_on_job_class"
    t.index ["labels"], name: "index_good_jobs_on_labels", where: "(labels IS NOT NULL)", using: :gin
    t.index ["locked_by_id"], name: "index_good_jobs_on_locked_by_id", where: "(locked_by_id IS NOT NULL)"
    t.index ["priority", "created_at"], name: "index_good_job_jobs_for_candidate_lookup", where: "(finished_at IS NULL)"
    t.index ["priority", "created_at"], name: "index_good_jobs_jobs_on_priority_created_at_when_unfinished", order: { priority: "DESC NULLS LAST" }, where: "(finished_at IS NULL)"
    t.index ["priority", "scheduled_at", "id"], name: "index_good_jobs_for_candidate_dequeue_unlocked", where: "((finished_at IS NULL) AND (locked_by_id IS NULL))"
    t.index ["priority", "scheduled_at", "id"], name: "index_good_jobs_on_priority_scheduled_at_unfinished", where: "(finished_at IS NULL)"
    t.index ["priority", "scheduled_at"], name: "index_good_jobs_on_priority_scheduled_at_unfinished_unlocked", where: "((finished_at IS NULL) AND (locked_by_id IS NULL))"
    t.index ["queue_name", "scheduled_at", "id"], name: "index_good_jobs_on_queue_name_priority_scheduled_at_unfinished", where: "(finished_at IS NULL)"
    t.index ["queue_name", "scheduled_at"], name: "index_good_jobs_on_queue_name_and_scheduled_at", where: "(finished_at IS NULL)"
    t.index ["queue_name"], name: "index_good_jobs_on_queue_name"
    t.index ["scheduled_at", "queue_name"], name: "index_good_jobs_on_scheduled_at_and_queue_name"
    t.index ["scheduled_at"], name: "index_good_jobs_on_scheduled_at", where: "(finished_at IS NULL)"
  end

  create_table "hosts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.inet "ipaddress"
    t.bigint "location_id", null: false
    t.string "name", default: ""
    t.bigint "software_group_id", null: false
    t.datetime "updated_at", null: false
    t.index ["location_id"], name: "index_hosts_on_location_id"
    t.index ["software_group_id"], name: "index_hosts_on_software_group_id"
  end

  create_table "interface_connectors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", default: ""
    t.bigint "software_interface_id", null: false
    t.string "type", default: ""
    t.datetime "updated_at", null: false
    t.string "url", default: ""
    t.index ["software_interface_id"], name: "index_interface_connectors_on_software_interface_id"
    t.index ["type"], name: "index_interface_connectors_on_type"
  end

  create_table "locations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "lid", null: false
    t.string "name", default: ""
    t.datetime "updated_at", null: false
    t.index ["lid"], name: "index_locations_on_lid"
  end

  create_table "notes", force: :cascade do |t|
    t.bigint "channel_id"
    t.bigint "channel_statistic_id"
    t.datetime "created_at", null: false
    t.bigint "notable_id"
    t.string "notable_type"
    t.bigint "server_id", null: false
    t.string "type", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.datetime "valid_until"
    t.index ["channel_id"], name: "index_notes_on_channel_id"
    t.index ["channel_statistic_id"], name: "index_notes_on_channel_statistic_id"
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable"
    t.index ["server_id"], name: "index_notes_on_server_id"
    t.index ["type"], name: "index_notes_on_type"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "notification_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", default: "", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_notification_groups_on_name"
  end

  create_table "notification_groups_wobauth_users", id: false, force: :cascade do |t|
    t.bigint "notification_group_id", null: false
    t.bigint "wobauth_user_id", null: false
    t.index ["notification_group_id", "wobauth_user_id"], name: "idx_notificationgroup_user"
    t.index ["wobauth_user_id", "notification_group_id"], name: "idx_user_notificationgroup"
  end

  create_table "server_configurations", force: :cascade do |t|
    t.string "comment", default: ""
    t.datetime "created_at", null: false
    t.bigint "server_id", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_server_configurations_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.bigint "acknowledge_id"
    t.text "api_password_ciphertext"
    t.string "api_url", default: ""
    t.string "api_user", default: ""
    t.boolean "api_user_has_full_access", default: true
    t.boolean "api_verify_ssl", default: false
    t.integer "condition", default: 0
    t.string "condition_message", default: ""
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "disabled", default: false
    t.bigint "host_id"
    t.datetime "last_channel_update", precision: nil
    t.datetime "last_check", precision: nil
    t.datetime "last_check_ok", precision: nil
    t.boolean "manual_update", default: false
    t.string "name", default: "", null: false
    t.jsonb "properties"
    t.string "uid", default: ""
    t.datetime "updated_at", null: false
    t.index ["condition"], name: "index_servers_on_condition"
    t.index ["host_id"], name: "index_servers_on_host_id"
    t.index ["uid"], name: "index_servers_on_uid"
  end

  create_table "software", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "location_id", null: false
    t.string "name", null: false
    t.bigint "software_group_id"
    t.datetime "updated_at", null: false
    t.string "vendor", default: ""
    t.index ["location_id"], name: "index_software_on_location_id"
    t.index ["software_group_id"], name: "index_software_on_software_group_id"
  end

  create_table "software_connections", force: :cascade do |t|
    t.integer "channel_ids", array: true
    t.datetime "created_at", null: false
    t.bigint "destination_connector_id"
    t.string "destination_url", default: ""
    t.boolean "ignore", default: false
    t.string "ignore_reason", default: ""
    t.bigint "location_id", null: false
    t.bigint "server_id"
    t.bigint "source_connector_id"
    t.string "source_url", default: ""
    t.datetime "updated_at", null: false
    t.index ["destination_connector_id"], name: "index_software_connections_on_destination_connector_id"
    t.index ["location_id", "source_url", "destination_url"], name: "index_loc_src_dst_url", unique: true
    t.index ["location_id"], name: "index_software_connections_on_location_id"
    t.index ["server_id"], name: "index_software_connections_on_server_id"
    t.index ["source_connector_id"], name: "index_software_connections_on_source_connector_id"
  end

  create_table "software_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", default: ""
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_software_groups_on_name", unique: true
  end

  create_table "software_interfaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "host_id"
    t.string "name", null: false
    t.bigint "software_id", null: false
    t.datetime "updated_at", null: false
    t.index ["host_id"], name: "index_software_interfaces_on_host_id"
    t.index ["software_id"], name: "index_software_interfaces_on_software_id"
  end

  create_table "wobauth_authorities", force: :cascade do |t|
    t.bigint "authorizable_id"
    t.string "authorizable_type"
    t.bigint "authorized_for_id"
    t.string "authorized_for_type"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "role_id"
    t.datetime "updated_at", precision: nil, null: false
    t.date "valid_from"
    t.date "valid_until"
    t.index ["authorizable_id"], name: "index_wobauth_authorities_on_authorizable_id"
    t.index ["authorized_for_id"], name: "index_wobauth_authorities_on_authorized_for_id"
    t.index ["role_id"], name: "index_wobauth_authorities_on_role_id"
  end

  create_table "wobauth_groups", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "wobauth_memberships", force: :cascade do |t|
    t.boolean "auto", default: false
    t.datetime "created_at", precision: nil, null: false
    t.bigint "group_id"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["group_id"], name: "index_wobauth_memberships_on_group_id"
    t.index ["user_id"], name: "index_wobauth_memberships_on_user_id"
  end

  create_table "wobauth_roles", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "wobauth_users", force: :cascade do |t|
    t.string "active_directory_guid"
    t.string "company", default: ""
    t.datetime "created_at", precision: nil, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "department", default: ""
    t.string "displayname"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "givenname"
    t.text "gruppen"
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.string "position", default: ""
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.string "sn"
    t.string "telephone"
    t.string "title", default: ""
    t.datetime "updated_at", precision: nil, null: false
    t.string "username", default: "", null: false
    t.string "userprincipalname"
    t.index ["reset_password_token"], name: "index_wobauth_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_wobauth_users_on_username", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "alerts", "servers"
  add_foreign_key "channel_statistics", "channels"
  add_foreign_key "channel_statistics", "servers"
  add_foreign_key "channels", "servers"
  add_foreign_key "escalation_times", "escalation_levels"
  add_foreign_key "hosts", "locations"
  add_foreign_key "hosts", "software_groups"
  add_foreign_key "interface_connectors", "software_interfaces"
  add_foreign_key "notes", "servers"
  add_foreign_key "notes", "wobauth_users", column: "user_id"
  add_foreign_key "server_configurations", "servers"
  add_foreign_key "servers", "hosts"
  add_foreign_key "software", "locations"
  add_foreign_key "software", "software_groups"
  add_foreign_key "software_connections", "locations"
  add_foreign_key "software_interfaces", "hosts"
  add_foreign_key "software_interfaces", "software"
end
