class Album < ApplicationRecord
    searchkick
    has_one_attached :image
    belongs_to :user
    has_many :reviews
    belongs_to :singer
    def avg_rating(album)
        a = Review.where(album_id: album.id).average(:rating)
        if a == nil
            return a = 0.0
        else
            return a.round(2)
        end
    end 

end
