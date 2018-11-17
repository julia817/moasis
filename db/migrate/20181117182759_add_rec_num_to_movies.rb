class AddRecNumToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :rec_num, :integer
  end
end
