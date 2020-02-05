require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
  let(:user) { create(:user) }
  before { login(:user) }

  describe 'POST #create' do
    let(:book) { create(:book) }
    let(:request_params) { { method: :post, action: :create, options: { comment: attributes_for(:rating), book_id: book, user_id: user }, format: :json } }
    let(:request_invalid_params) { { method: :post, action: :create, options: { comment: attributes_for(:rating, :invalid), book_id: book, user_id: user }, format: :json } }

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new rating in the database' do
        expect { do_request(request_params) }.to change(Rating, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'return :unprocessable_entity' do
        do_request(request_invalid_params)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not save new rating in the database' do
        expect { do_request(request_invalid_params) }.to_not change(Rating, :count)
      end
    end
  end
end
