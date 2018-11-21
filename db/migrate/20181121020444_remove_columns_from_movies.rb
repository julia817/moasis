class RemoveColumnsFromMovies < ActiveRecord::Migration[5.0]
  def change
  	remove_column :movies, :title
  	remove_column :movies, :date
  	remove_column :movies, :story
  	remove_column :movies, :posterpath
  	remove_column :movies, :original_title
  	remove_column :movies, :pic_path
  	remove_column :movies, :genre
  end
end
