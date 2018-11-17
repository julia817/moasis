class AddScoreToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :score, :integer
  end
end
