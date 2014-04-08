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

ActiveRecord::Schema.define(version: 20140408224825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ability_trainabilities", force: true do |t|
    t.integer  "character_class_id"
    t.integer  "character_ability_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "armors", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "js_class"
    t.integer  "ac_bonus"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "armor_type"
  end

  create_table "character_abilities", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.text     "description"
    t.string   "dependent_on_stat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "js_class"
  end

  create_table "character_ability_assignments", force: true do |t|
    t.integer  "character_id"
    t.integer  "character_ability_id"
    t.integer  "mastery"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "trained",              default: false
  end

  create_table "character_availabilities", force: true do |t|
    t.integer  "skill_id"
    t.integer  "character_class_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_classes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "js_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "character_perk_assignments", force: true do |t|
    t.integer "character_id"
    t.integer "perk_id"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "str",                   default: 10
    t.integer  "con",                   default: 10
    t.integer  "dex",                   default: 10
    t.integer  "int",                   default: 10
    t.integer  "wis",                   default: 10
    t.integer  "cha",                   default: 8
    t.integer  "speed",                 default: 6
    t.integer  "xp",                    default: 0
    t.integer  "level",                 default: 1
    t.integer  "stat_points",           default: 22
    t.integer  "hp",                    default: 0
    t.integer  "max_hp",                default: 0
    t.integer  "stamina",               default: 0
    t.integer  "reaction",              default: 0
    t.integer  "will",                  default: 0
    t.integer  "ac",                    default: 0
    t.integer  "race_id"
    t.integer  "character_class_id"
    t.integer  "right_hand_weapon_id"
    t.integer  "left_hand_weapon_id"
    t.integer  "heals_count",           default: 0
    t.integer  "initiative_bonus"
    t.integer  "trainings_count",       default: 0
    t.integer  "armor_id"
    t.integer  "shield_id"
    t.integer  "weapon_id"
    t.integer  "character_ability_ids", default: [], array: true
    t.integer  "stat_increment_points", default: 0
    t.integer  "deity_id"
    t.text     "perk_settings"
  end

  create_table "combats", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "json"
    t.string   "background_file_name"
    t.string   "background_content_type"
    t.integer  "background_file_size"
    t.datetime "background_updated_at"
  end

  create_table "deities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "game_assignments", force: true do |t|
    t.integer  "game_id"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_invitations", force: true do |t|
    t.integer  "character_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "master_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "monsters", force: true do |t|
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "monster_type"
    t.integer  "level"
    t.string   "size"
    t.integer  "hp"
    t.integer  "initiative"
    t.integer  "ac"
    t.integer  "endurance"
    t.integer  "reaction"
    t.integer  "will"
    t.integer  "speed"
    t.integer  "str",                 default: 0
    t.integer  "con",                 default: 0
    t.integer  "dex",                 default: 0
    t.integer  "int",                 default: 0
    t.integer  "wis",                 default: 0
    t.integer  "cha",                 default: 0
  end

  create_table "perks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "js_class"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree

  create_table "races", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "js_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "size"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "skill_assignments", force: true do |t|
    t.string  "owner_type"
    t.integer "skill_id"
    t.integer "owner_id"
  end

  create_table "skills", force: true do |t|
    t.string   "title"
    t.string   "attack_char_from"
    t.string   "attack_char_to"
    t.integer  "damage_dice",         default: 0
    t.integer  "damage_count",        default: 1
    t.integer  "damage_bonus",        default: 0
    t.string   "js_class"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
    t.string   "cooldown_type"
    t.integer  "min_level",           default: 1
  end

  create_table "weapon_assignments", force: true do |t|
    t.string  "owner_type"
    t.integer "owner_id"
    t.integer "weapon_id"
  end

  add_index "weapon_assignments", ["owner_id"], name: "index_weapon_assignments_on_owner_id", using: :btree

  create_table "weapon_groups", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weapons", force: true do |t|
    t.string   "title"
    t.integer  "damage_dice",         default: 0
    t.integer  "damage_count",        default: 1
    t.integer  "prof",                default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attack_char_from"
    t.string   "attack_char_to"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "js_class"
    t.integer  "weapon_group_id"
    t.boolean  "aux",                 default: false
    t.boolean  "high_crit",           default: false
  end

end
