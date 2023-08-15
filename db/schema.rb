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

ActiveRecord::Schema[7.0].define(version: 20_230_801_022_113) do
  create_table 'categories', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'games', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'title', null: false
    t.text 'description'
    t.string 'logo_url'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['title'], name: 'index_games_on_title', unique: true
  end

  create_table 'keywords', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'category_id', null: false
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_keywords_on_category_id'
  end

  create_table 'memos', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'video_id', null: false
    t.bigint 'user_id', null: false
    t.text 'content', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_memos_on_user_id'
    t.index ['video_id'], name: 'index_memos_on_video_id'
  end

  create_table 'playlist_videos', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'playlist_id', null: false
    t.bigint 'video_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['playlist_id'], name: 'index_playlist_videos_on_playlist_id'
    t.index ['video_id'], name: 'index_playlist_videos_on_video_id'
  end

  create_table 'playlists', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'title', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_playlists_on_user_id'
  end

  create_table 'users', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'email', null: false
    t.string 'crypted_password'
    t.string 'salt'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'role', default: 0, null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_token_expires_at'
    t.datetime 'reset_password_email_sent_at'
    t.integer 'access_count_to_reset_password_page', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token'
  end

  create_table 'uservideos', charset: 'utf8mb4', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.bigint 'video_id', null: false
    t.integer 'watched_status', default: 0, null: false
    t.datetime 'watched_at'
    t.datetime 'practiced_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_uservideos_on_user_id'
    t.index ['video_id'], name: 'index_uservideos_on_video_id'
  end

  create_table 'videos', charset: 'utf8mb4', force: :cascade do |t|
    t.string 'title'
    t.string 'thumbnail_url'
    t.string 'embed_code'
    t.bigint 'game_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'category_id', null: false
    t.string 'video_id'
    t.index ['category_id'], name: 'index_videos_on_category_id'
    t.index ['game_id'], name: 'index_videos_on_game_id'
  end

  add_foreign_key 'keywords', 'categories'
  add_foreign_key 'memos', 'users'
  add_foreign_key 'memos', 'videos'
  add_foreign_key 'playlist_videos', 'playlists'
  add_foreign_key 'playlist_videos', 'videos'
  add_foreign_key 'playlists', 'users'
  add_foreign_key 'uservideos', 'users'
  add_foreign_key 'uservideos', 'videos'
  add_foreign_key 'videos', 'categories'
  add_foreign_key 'videos', 'games'
end
