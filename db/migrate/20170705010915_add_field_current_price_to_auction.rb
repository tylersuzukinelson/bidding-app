class AddFieldCurrentPriceToAuction < ActiveRecord::Migration[5.1]
  def change
    add_column :auctions, :current_price, :decimal
  end
end
