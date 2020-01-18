class User < ApplicationRecord
  before_validation { email.downcase! }

  has_secure_password

  mount_uploader :profile_photo, ImageUploader

  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum:30}
  validates :email, presence: true, length: { maximum:255}
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :email, uniqueness: true
end
