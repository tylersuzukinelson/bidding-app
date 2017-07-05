class PublishingsController < ApplicationController

  def create
    auction = Auction.find params[:auction_id]
    if auction.publish!
      redirect_to auction, notice: 'Auction published!'
    else
      redirect_to auction, notice: 'Auction not published!'
    end

    # if auction.cancel!
    #   redirect_to auction, notice: 'Auction cancelled!'
    # else
    #   redirect_to auction, notice: 'Auction not cancelled!'
    # end
    #
    # if auction.reserve!
    #   redirect_to auction, notice: 'Auction reserved!'
    # else
    #   redirect_to auction, notice: 'Auction not reserved!'
    # end
    #
    # if auction.win!
    #   redirect_to auction, notice: 'Auction won!'
    # else
    #   redirect_to auction, notice: 'Auction not won!'
    # end
    #
    # if auction.unreserve!
    #   redirect_to auction, notice: 'Auction unreserved!'
    # else
    #   redirect_to auction, notice: 'Auction could not unreserved!'
    # end

  end
end
