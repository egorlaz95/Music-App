class AddCoverToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :cover, :string
  end
end
