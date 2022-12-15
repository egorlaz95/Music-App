class AddLinkToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :link, :string
  end
end
