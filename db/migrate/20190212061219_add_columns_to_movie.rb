class AddColumnsToMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :title, :string
    add_column :movies, :genres, :string
    add_column :movies, :poster_path, :string
  end
end
