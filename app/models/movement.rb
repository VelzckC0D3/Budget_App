class Movement < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, presence: true
  validates :amount, presence: true
  validates :group_id, presence: true
end
