class RemoveColumnsFromAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :language, :string
    remove_column :albums, :genre, :string
    remove_column :albums, :released, :string
    remove_column :albums, :album_length, :string
    remove_column :albums, :link, :string
  end
end
