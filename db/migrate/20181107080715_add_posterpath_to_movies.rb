class AddPosterpathToMovies < ActiveRecord::Migration[5.0]
  def change
  	add_column :movies, :posterpath, :string
  end
end
