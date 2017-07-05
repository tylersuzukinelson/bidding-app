class RemoveFieldFromAuction < ActiveRecord::Migration[5.1]
  def change
    remove_column :auctions, :reserved_price, :decimal
  end
end
