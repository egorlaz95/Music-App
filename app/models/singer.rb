class Singer < ApplicationRecord
  has_many :albums, dependent: :destroy
  belongs_to :user
  has_one_attached :image
end
