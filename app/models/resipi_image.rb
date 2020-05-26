class ResipiImage < ApplicationRecord
  belongs_to :main,optional: true
  belongs_to :sub,optional: true
  belongs_to :soop,optional: true
  belongs_to :menu,optional: true
  mount_uploader :image, ImageUploader
end
