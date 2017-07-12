class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :user

  validates :bid, numericality: { greater_than: :current_bid }

  def current_bid
    self.auction.current_price
  end


end
