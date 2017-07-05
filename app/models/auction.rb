class Auction < ApplicationRecord
  has_many :bids, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false}
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
