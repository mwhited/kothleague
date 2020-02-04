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

ActiveRecord::Schema.define(version: 2020_02_04_214054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "teamsize"
    t.integer "points_for_win"
    t.integer "points_for_loss"
  end

  create_table "games", force: :cascade do |t|
    t.bigint "team1_id", null: false
    t.bigint "team2_id", null: false
    t.integer "t1score"
    t.integer "t2score"
    t.bigint "round_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "complete"
    t.index ["round_id"], name: "index_games_on_round_id"
    t.index ["team1_id"], name: "index_games_on_team1_id"
    t.index ["team2_id"], name: "index_games_on_team2_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.decimal "tdeviation"
    t.decimal "tskill"
    t.integer "points"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_players_on_event_id"
  end

  create_table "players_rounds", id: false, force: :cascade do |t|
    t.bigint "round_id", null: false
    t.bigint "player_id", null: false
  end

  create_table "players_teams", id: false, force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "player_id", null: false
  end

  create_table "rank_histories", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "game_id", null: false
    t.decimal "tskill"
    t.decimal "tdeviation"
    t.integer "points"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_rank_histories_on_game_id"
    t.index ["player_id"], name: "index_rank_histories_on_player_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.datetime "datetime"
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "started", default: false
    t.integer "numgames", default: 0
    t.index ["event_id"], name: "index_rounds_on_event_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_teams_on_event_id"
  end

  add_foreign_key "games", "rounds"
  add_foreign_key "games", "teams", column: "team1_id"
  add_foreign_key "games", "teams", column: "team2_id"
  add_foreign_key "players", "events"
  add_foreign_key "rank_histories", "games"
  add_foreign_key "rank_histories", "players"
  add_foreign_key "rounds", "events"
  add_foreign_key "teams", "events"
end
