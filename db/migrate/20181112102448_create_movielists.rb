class CreateMovielists < ActiveRecord::Migration[5.0]
  def change
    create_table :movielists do |t|
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :movielists, [:user_id, :created_at]
  end
end
