class AddFieldReservePriceToAuction < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :reserve_price, :decimal, default: 1
  end
end
