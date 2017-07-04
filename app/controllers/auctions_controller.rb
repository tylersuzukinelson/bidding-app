class AuctionsController < ApplicationController
  before_action :find_auction, only: [:show, :edit, :update, :destroy]

  def index
    @auctions = Auction.all
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    if @auction.save
      flash[:notice] = "Auction created"
      redirect_to auctions_path
    else
      flash.now[:alert] = "Please fix errors"
      render :new
    end
  end

  def show
    # @auction = Auction.find params[:id]
    @bid = Bid.new
    @bids = @auction.bids.order(created_at: :desc)
  end

  def edit
    # @auction = Auction.find params[:id]
  end

  def update
    # @auction = Auction.find params[:id]

    if @auction.update(auction_params)
      redirect_to auctions_path, notice: "Successfully Updated"
    else
      flash.now[:alert] = 'Please fix errors'
      render :edit
    end

  end

  def destroy
    # @auction = Auction.find params[:id]
    @auction.destroy
    redirect_to auctions_path, alert: "Auction Deleted"
  end

  private

  def auction_params
    params.require(:auction).permit([:title, :details, :ends_on, :reserved_price])
  end

  def find_auction
  @auction = Auction.find params[:id]
  end
end
