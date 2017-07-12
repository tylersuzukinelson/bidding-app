class Auction < ApplicationRecord
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false}
  # Doesn't this just check that the reserve_price == reserve_price?
  # ie. isn't it always true?
  validates :reserve_price, numericality: { greater_than_or_equal_to: :default_auction_price }

  def default_auction_price
    self.reserve_price ||= 1
  end

  before_save :default_values

  def default_values
    self.current_price ||= self.reserve_price
  end

  def set_current_price
    self.reserve_price
  end

  include AASM
  aasm do
    state :draft, initial: true
    state :published, :reserve_met, :won, :canceled, :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :cancel do
      transitions from: [:published, :draft, :reserve_met, :reserve_not_met], to: :canceled
    end

    event :reserve do
      transitions from: [:published], to: :reserve_met
    end

    event :unreserve do
      transitions from: :reserve_met, to: :reserve_not_met
    end

    event :win do
      transitions from: [:reserve_met], to: :won
    end

  end
end
