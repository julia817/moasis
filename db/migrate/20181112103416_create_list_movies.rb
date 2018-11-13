class CreateListMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :list_movies do |t|
      t.references :movielist, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
    add_index :list_movies, [:movielist_id, :movie_id, :created_at]
  end
end
