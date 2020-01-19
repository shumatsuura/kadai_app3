class Feed < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  mount_uploader :image, ImageUploader
  validates :content, presence:true
  validates :image, presence:true
end
