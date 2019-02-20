class SearchController < ApplicationController
  # enum search_type: { 映画: 0, 俳優: 1, ユーザ: 2 }

  def search_filter
    @genres = GENRES
  end

  def discover
    @search_type = params[:search_type]
    if @search_type == "movie"
      redirect_to :action => "search_movies", :looking_for => params[:looking_for]
    elsif @search_type == "people"
      redirect_to :action => "search_people", :looking_for => params[:looking_for]
    else
      redirect_to :action => "search_users", :looking_for => params[:looking_for]
    end
  end

  def search_movies
    @search_term = params[:looking_for]
    if @search_term.blank?
      flash[:danger] = "検索キーワードが入力されていません"
      redirect_to root_path
    else
      response = Movie.search(@search_term)
      @total_results = response["total_results"]
      unless @total_results == 0
        @total_pages = response["total_pages"]
        @movie_results = response["results"]
        if @total_pages>1
          @total_pages = @total_pages>30 ? 30 : @total_pages
          (2..@total_pages).each do |page|
            results = Movie.search(@search_term, page)["results"]
            (0...results.count).each do |i|
              @movie_results << results[i]
            end
          end
        end
      end
      add_movies_to_db @movie_results
      @movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
    end
  end

  def search_people
    @search_term = params[:looking_for]
    if @search_term.blank?
      flash[:danger] = "検索キーワードが入力されていません"
      redirect_to root_path
    else
      response = Movie.people(@search_term)
      @total_results = response["total_results"]
      unless @total_results == 0
        @total_pages = response["total_pages"]
        @people_results = response["results"]
        if @total_pages>1
          @total_pages = @total_pages>30 ? 30 : @total_pages
          (2..@total_pages).each do |page|
            results = Movie.people(@search_term, page)["results"]
            (0...results.count).each do |i|
              @people_results << results[i]
            end
          end
        end
      end
      @people_results = Kaminari.paginate_array(@people_results).page(params[:page]).per(20) unless @people_results.blank?
    end
  end

  def search_users
    @search_term = params[:looking_for]
    if @search_term.blank?
      flash[:danger] = "検索キーワードが入力されていません"
      redirect_to root_path
    else
      @users = User.search(@search_term).paginate(page: params[:page])
    end
  end

  def advanced_search
    @year = params[:year][0]
    @person1 = params[:person1][0]
    @person2 = params[:person2][0]
    people = @person2.empty? ? @person1 : "#{@person1},#{@person2}"
    @genres = GENRES
    @genre_id = params[:genre]

    response = Movie.discover(@year, @genre_id, people)
    @total_pages = response["total_pages"]
    @movie_results = response["results"]

    @total_pages = @total_pages>30 ? 30 : @total_pages
    (2..@total_pages).each do |page|
      results = Movie.discover(@year, @genre_id, people, page)["results"]
      (0...results.count).each do |i|
        @movie_results << results[i]
      end
    end
    add_movies_to_db @movie_results
    @movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
  end

  def show_genre
    @name = params[:name]
    @genres = GENRES

    response = Movie.genre_list(params[:id])
    @total_pages = response["total_pages"]
    @movie_results = response["results"]

    @total_pages = @total_pages>30 ? 30 : @total_pages
    (2..@total_pages).each do |page|
      results = Movie.genre_list(params[:id], page)["results"]
      (0...results.count).each do |i|
        @movie_results << results[i]
      end
    end
    add_movies_to_db @movie_results
    @movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
  end

  def show_single_year
    @year = params[:year][0..3]
    @genres = GENRES

    response = Movie.year_list(params[:year])
    @total_pages = response["total_pages"]
    @movie_results = response["results"]

    @total_pages = @total_pages>30 ? 30 : @total_pages
    (2..@total_pages).each do |page|
      results = Movie.year_list(params[:year], page)["results"]
      (0...results.count).each do |i|
        @movie_results << results[i]
      end
    end
    add_movies_to_db @movie_results
    @movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
  end

  def show_90s
    response = Movie.years90s_list(params[:lower], parmas[:upper])
    @total_pages = response["total_pages"]
    @movie_results = response["results"]

    @total_pages = @total_pages>30 ? 30 : @total_pages
    (2..@total_pages).each do |page|
      results = Movie.years90s_list(params[:lower], parmas[:upper], page)["results"]
      (0...results.count).each do |i|
        @movie_results << results[i]
      end
    end

    @movie_results = Kaminari.paginate_array(@movie_results).page(params[:page]).per(20) unless @movie_results.blank?
  end
end
