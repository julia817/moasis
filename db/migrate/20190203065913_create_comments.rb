class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end

    add_index :comments, [:user_id, :movie_id, :created_at], unique: true
  end
end
