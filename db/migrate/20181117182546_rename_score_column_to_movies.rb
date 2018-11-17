class RenameScoreColumnToMovies < ActiveRecord::Migration[5.0]
  def change
  	rename_column :movies, :score, :watched_num
  end
end
