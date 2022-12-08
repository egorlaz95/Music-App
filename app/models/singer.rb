class Singer < ApplicationRecord
    has_many :albums
    belongs_to :user
    has_one_attached :image
end
