class Auction < ApplicationRecord
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false}
end
