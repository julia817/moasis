class StaticPagesController < ApplicationController
  def home
    response = Movie.now_playing
    @movies = Array.new
    response.each do |m|
      if !m["backdrop_path"].blank?
        @movies << m
      end
    end
    if @movies.count<12
      response = Movie.now_playing(2)
      response.each do |m|
        if !m["backdrop_path"].blank?
          @movies << m
        end
      end
    end
    # @movies = @movies.sort_by{ |e| e["release_date"]}.reverse
    
    add_movies_to_db @movies
  end

  def about
  end

  def help
  end

  def contact
  end
end
