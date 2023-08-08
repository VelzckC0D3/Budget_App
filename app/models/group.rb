class Group < ApplicationRecord
  belongs_to :user
  has_many :movements

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true
end
