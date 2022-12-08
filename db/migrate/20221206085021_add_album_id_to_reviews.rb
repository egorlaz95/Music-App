class AddAlbumIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :album_id, :integer
  end
end
