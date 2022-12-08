json.extract! album, :id, :title, :artist, :language, :released, :genre, :album_length, :created_at, :updated_at
json.url album_url(album, format: :json)
