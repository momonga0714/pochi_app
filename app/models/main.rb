class Main < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  has_many :menus
  belongs_to :user
  has_many :resipi_images, dependent: :destroy
  accepts_nested_attributes_for :resipi_images, allow_destroy: true
  belongs_to_active_hash :genre
  belongs_to_active_hash :type

  validates :main_name,              presence: true, uniqueness: { scope: :user_id}
  validates :genre_id,               presence: true
  validates :type_id,                presence: true
  
    def first_image
      resipi_images.first
    end
    
    scope :search, -> (search){where('main_name LIKE(?)', "%#{search}%")}
end
