require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:auction) {FactoryGirl.create(:auction)}
  # def valid_auction
  #   auction :create, params: { auction: attributes_for(:auction) }
  # end

# NEW ACTION TEST
  describe '#new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

# CREATE ACTION TESTS
  describe '#create' do
    context 'with valid attributes' do
      def valid_request
        attributes = FactoryGirl.attributes_for(:auction)
        post :create, params: { auction: attributes }
      end
      it 'creates a new auction in database' do
        count_before = Auction.count
        valid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before + 1)
      end
      it "redirects to the product show page" do
        valid_request
        expect(response).to redirect_to(auctions_path)
      end
      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    context "with invalid attribute" do
      def invalid_request
        post :create, params: {auction: FactoryGirl.attributes_for(:auction, title: nil)}
      end
      it "does not create a record in the database part2" do
        count_before = Auction.count
        invalid_request
        count_after = Auction.count
        expect(count_after).to eq(count_before)
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
      it "sets a flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end

  end

  # INDEX ACTION TESTS

  describe "#index" do
    it "renders auctions template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  # SHOW ACTION TESTS
  describe "#show" do
    it "it renders a auction show template" do
      get :show, params: {id: auction.id}
      expect(response).to render_template(:show)
    end
  end

  # DESTROY ACTION TESTS
  describe "#destroy" do
    context "Removing an auction" do
      it "redirects to index" do
        delete :destroy, params: { id: auction.id }
        expect(response).to redirect_to(auctions_path)
      end
      it "sets a flash message" do
        delete :destroy, params: { id: auction.id }
        expect(flash[:alert]).to be
      end
    end
  end

  # UPDATE ACTION TESTS
  describe '#update' do
    context "updating auctions" do

      it "updates the title" do
        patch :update, params: { id: auction.id, auction: { title: 'new title'} }
        expect(auction.reload.title).to eq('new title')
      end

      it "sets a flash message" do
        patch :update, params: { id: auction.id, auction: { title: 'new title'} }
        expect(flash[:notice]).to be
      end

    end
  end

end
