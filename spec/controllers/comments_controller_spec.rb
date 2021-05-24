# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe CommentsController, type: :controller do
  before { login(create(:user)) }

  describe 'POST #create' do
    let(:book) { create(:book) }
    let(:request_params) do
      { method: :post,
        action: :create,
        options: { comment: attributes_for(:comment), book_id: book },
        format: :json }
    end
    let(:request_invalid_params) do
      { method: :post,
        action: :create,
        options: { comment: attributes_for(:comment, :invalid), book_id: book },
        format: :json }
    end

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new comment in the database' do
        expect { do_request(request_params) }
          .to change(Comment, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'return :unprocessable_entity' do
        do_request(request_invalid_params)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not save new comment in the database' do
        expect { do_request(request_invalid_params) }
          .to_not change(Comment, :count)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
