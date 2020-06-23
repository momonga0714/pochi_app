class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :mains
  has_many :subs
  has_many :soops

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,              presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password,           presence: true, length: { minimum: 7 }
  validates :encrypted_password, presence: true, length: { minimum: 7 }
end
