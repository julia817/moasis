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

ActiveRecord::Schema.define(version: 20190213021537) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "likes_count", default: 0
    t.index ["movie_id"], name: "index_comments_on_movie_id"
    t.index ["user_id", "movie_id", "created_at"], name: "index_comments_on_user_id_and_movie_id_and_created_at", unique: true
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_likes_on_comment_id"
    t.index ["user_id", "comment_id"], name: "index_likes_on_user_id_and_comment_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "list_movies", force: :cascade do |t|
    t.integer  "movielist_id"
    t.integer  "movie_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "history"
    t.index ["movie_id"], name: "index_list_movies_on_movie_id"
    t.index ["movielist_id", "movie_id"], name: "index_list_movies_on_movielist_id_and_movie_id", unique: true
    t.index ["movielist_id"], name: "index_list_movies_on_movielist_id"
  end

  create_table "movielists", force: :cascade do |t|
    t.string   "listname"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_movielists_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_movielists_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "watched_num"
    t.integer  "rec_num"
    t.string   "title"
    t.string   "genres"
    t.string   "poster_path"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.string   "picture"
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "uid"
    t.string   "pic_url"
    t.string   "provider"
  end

end
