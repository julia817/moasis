class MoviesController < ApplicationController
  include MoviesHelper

  def show
    @movie = Movie.details(params[:id])
    if @movie["credits"]["cast"].count > 6
      @cast_range = 6
    else
      @cast_range = @movie["credits"]["cast"].count
    end
    @trailers = Movie.trailers(params[:id])

    @directors = {}
    @writers = {}
    @story = {}
    @screenplay = {}
    @novel = {}
    @music = {}
    @movie["credits"]["crew"].each do |crew|
      if crew["job"]=="Director" then @directors[crew["name"]] = crew["id"] end
      if crew["job"]=="Writer" then @writers[crew["name"]] = crew["id"] end
      if crew["job"]=="Story" then @story[crew["name"]] = crew["id"] end
      if crew["job"]=="Screenplay" then @screenplay[crew["name"]] = crew["id"] end
      if crew["job"]=="Novel" then @novel[crew["name"]] = crew["id"] end
      if crew["job"]=="Original Music Composer" then @music[crew["name"]] = crew["id"] end
    end
    @directors_count = @directors.size
    @writers_count = @writers.size
    @story_count = @story.size
    @screenplay_count = @screenplay.size
    @novel_count = @novel.size
    @music_count = @music.size


    # get current user's comment
    @current_user_comment = Comment.find_by(user_id: current_user.id, movie_id: @movie["id"]) if logged_in?
    # create new comment
    @comment = Comment.new if logged_in? && watched_check(@movie["id"])
    if Movie.exists?(@movie["id"])
      # find movie object from database
      @movie_db = Movie.find(@movie["id"])
      # paginate all of the movie's comments
      @comments = @movie_db.comments.paginate(page: params[:page])
    end
  end

  def show_collection
    @collection = Movie.collection(params[:id])
    @parts = @collection["parts"]
    @parts.sort_by! { |a| a["release_date"] }
    add_movies_to_db @parts
  end

  def show_person
    @person = Movie.person_details(params[:id])
    # @person["also_known_as"].each do |n|
    #   if !(n =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/).nil?
    #     @name = n
    #     break
    #   end
    # end
    # @name = @name.nil? ? @person["name"] : @name
    # @famous = ActiveSupport::JSON.decode(params[:known_for])
    @movie_credits = Array.new
    if @person["known_for_department"] == "Acting"
      @person["movie_credits"]["cast"].each do |movie|
        if movie["character"].blank? || movie["release_date"].blank?
          next
        end
        @movie_credits << movie
      end
    end
    add_movies_to_db @movie_credits unless @movie_credits.blank?
  end

end
