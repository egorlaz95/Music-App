class AddColumnsToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :label, :string
    add_column :albums, :release_date, :string
    add_column :albums, :total_tracks, :integer
    add_column :albums, :popularity, :integer
  end
end
