class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movements
  has_many :groups

  validates :name, presence: true, allow_blank: false, length: { minimum: 3, maximum: 50 }
  validates :profile_picture, presence: true, allow_blank: false
end
