class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :artist
      t.string :language
      t.string :released
      t.string :genre
      t.string :album_length

      t.timestamps
    end
  end
end
