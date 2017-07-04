class Auction < ApplicationRecord
  has_many :bids, dependent: :destroy

  validates :title, presence: true, uniqueness: { case_sensitive: false}
end
