class Menu < ApplicationRecord
  belongs_to :main
  belongs_to :sub
  belongs_to :soop
  has_many :resipi_images, dependent: :destroy
  accepts_nested_attributes_for :resipi_images, allow_destroy: true
end
