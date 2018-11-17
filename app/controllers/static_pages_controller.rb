class StaticPagesController < ApplicationController
  def home
  	@movies = Movie.now_playing
  	@movies.each do |m|
  		if m["backdrop_path"].nil?
  			@movies.delete(m)
  		end
  	end
  	# @movies = @movies.sort_by{ |e| e["release_date"]}.reverse
  end

  def about
  end

  def help
  end

  def contact
  end
end
