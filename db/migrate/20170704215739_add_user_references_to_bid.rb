class AddUserReferencesToBid < ActiveRecord::Migration[5.1]
  def change
    add_reference :bids, :user, foreign_key: true, index: true
  end
end
