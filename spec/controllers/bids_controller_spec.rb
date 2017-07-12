require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:auction) { FactoryGirl.create(:auction)}
  let(:bid) { FactoryGirl.create(:bid)}

  describe '#create' do
    context 'valid params' do
      def valid_request
        attributes = FactoryGirl.attributes_for(:bid)
        post :create, params: { bid: attributes, auction_id: auction.id }
      end

      it "creates a new auction in database" do
        # ditto auction controller specs
        count_before = Bid.count
        valid_request
        count_after = Bid.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'sets a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end
    end
  end

  describe '#destroy' do
    context 'deleting a bid' do
      def valid_request
        delete :destroy, params: {id: bid.id, auction_id: auction.id}
      end

      it "destroys a bid from database" do
        # ditto auction controller specs
        count_before = Bid.count
        valid_request
        count_after = Bid.count
        expect(count_after).to eq(count_before - 1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
  end

end
