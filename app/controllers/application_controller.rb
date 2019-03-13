class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  GENRES = { 'アクション' => 28, '冒険' => 12, 'コメディー' => 35, 'アニメーション' => 16, '犯罪' => 80, 'SF' => 878, 
             'ミステリー' => 9648, 'ファンタシー' => 14, 'ロマンス' => 10749, 'ホラー' => 27, '音楽' => 10402, 'ファミリー' => 10751, 
             'ドラマ' => 18, '歴史' => 36, '戦争' => 10752, 'スリラー' => 53, 'ドキュメンタリー' => 99, '西部劇' => 37 }

  # confirm a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください。"
      redirect_to login_path
    end
  end

  # add list-up movies to database
  def add_movies_to_db movies
    # genres = ""
    movies.each do |m|
      unless Movie.exists?(m["id"])
        # m["genre_ids"].each do |id|
        #   genres << GENRES.key(id)+',' unless m["genre_ids"].blank?
        # end
        Movie.add(m["id"], m["title"], m["poster_path"], m["genre_ids"])
      end
    end
  end

  def add_movie_to_db movie
    unless Movie.exists?(movie["id"])
      ids_arr = Array.new
      ids_str = movie["genres_ids"]
      movie["genres"].each do |genre|
        ids_arr << genre["id"]
      end
      Movie.add(movie["id"], movie["title"], movie["poster_path"], ids_arr) unless ids_arr.nil?
      Movie.add(movie["id"], movie["title"], movie["poster_path"], ids_str) unless ids_str.nil?
    end
  end
end
