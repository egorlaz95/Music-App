class AddSingerIdToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :singer_id, :integer
  end
end
