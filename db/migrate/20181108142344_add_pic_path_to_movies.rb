class AddPicPathToMovies < ActiveRecord::Migration[5.0]
  def change
  	add_column :movies, :pic_path, :string
  end
end
