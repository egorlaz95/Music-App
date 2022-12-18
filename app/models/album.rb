class Album < ApplicationRecord
  searchkick
  has_one_attached :image
  belongs_to :user
  has_many :reviews, dependent: :destroy
  belongs_to :singer
  def avg_rating(album)
    a = Review.where(album_id: album.id).average(:rating)
    return a = 0.0 if a.nil?

    a.round(2)
  end
end
