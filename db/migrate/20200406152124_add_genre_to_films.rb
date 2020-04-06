class AddGenreToFilms < ActiveRecord::Migration[5.2]
  def change
    add_column :films, :genre, :text
  end
end
