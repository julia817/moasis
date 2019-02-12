class AddHistoryToListMovie < ActiveRecord::Migration[5.0]
  def change
    add_column :list_movies, :history, :string
  end
end
