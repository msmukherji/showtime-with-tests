class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.string :user_id
      t.string :movie_id
      
      t.timestamps null: false
    end
  end
end
