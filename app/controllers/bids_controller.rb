class BidsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_bid, only: [:destroy]

  def create
    @auction = Auction.find params[:auction_id]
    @bid = Bid.new bid_params
    @bid.auction = @auction
    @bid.user = current_user
    # This belongs in a transaction. What if 
    # the auction fails to update?
    # Also, consider using a service object
    if @bid.save
      @auction.update_attributes(current_price: @bid.bid)
      redirect_to auction_path(@auction), notice: "Bid Created"
    else
      render 'auctions/show'
    end
  end

  def destroy
    @auction = @bid.auction # or
    # @auction = Auction.find params[:auction_id]
    @bid.destroy
    redirect_to auction_path(@auction), notice: 'Bid Deleted!'
  end


  private

  def find_bid
    @bid = Bid.find(params[:id])
  end

  def bid_params
    params.require(:bid).permit(:bid)
  end
end
