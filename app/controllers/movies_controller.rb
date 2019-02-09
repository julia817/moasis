class MoviesController < ApplicationController
  include MoviesHelper

  def show
    # @movie = Movie.find(params[:id])
    # @movie_credits = Movie.credits params[:id]
    @movie = Movie.details(params[:id])
    if @movie["credits"]["cast"].count > 5
      @cast_range = 5
    else
      @cast_range = @movie["credits"]["cast"].count
    end
    @trailers = Movie.trailers(params[:id])
    # @collection = Movie.collection(@movie["belongs_to_collection"]["id"])

    # get current user's comment
    @current_user_comment = Comment.find_by(user_id: current_user.id, movie_id: @movie["id"]) if logged_in?
    # create new comment
    @comment = Comment.new if logged_in? && watched_check(@movie["id"])
    # find movie object from database
    @movie_db = Movie.find(@movie["id"])
    # paginate all of the movie's comments
    @comments = @movie_db.comments.paginate(page: params[:page])
  end

  def show_collection
    @collection = Movie.collection(params[:id])
    @parts = @collection["parts"]
    @parts.sort_by! { |a| a["release_date"] }
  end

  def show_person
    @person = Movie.person_details(params[:id])
    @person["also_known_as"].each do |n|
      if !(n =~ /(?:\p{Hiragana}|\p{Katakana}|[一-龠々])/).nil?
        @name = n
        break
      end
    end
    @name = @name.nil? ? @person["name"] : @name
    # @famous = ActiveSupport::JSON.decode(params[:known_for])
  end

end
