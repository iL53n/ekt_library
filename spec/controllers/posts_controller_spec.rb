# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  before { login(user) }

  describe 'GET #index' do
    let!(:posts) { create_list(:post, 5) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'return 2xx' do
      do_request(request_params)
      expect(response).to have_http_status(:success)
    end

    it 'populates an array of all posts' do
      do_request(request_params)
      expect(assigns(:posts)).to match_array(posts)
    end
  end

  describe 'POST #create' do
    let(:book) { create(:book) }
    let(:request_params) do
      { method: :post,
        action: :create,
        options: { title: 'reading', book_id: book.id, user_id: user.id },
        format: :json }
    end
    let(:request_invalid_params) do
      { method: :post,
        action: :create,
        options: { title: '', book_id: book.id, user_id: user.id },
        format: :json }
    end

    context 'callbacks' do
      before { do_request(request_params) }

      it 'assign the requested book to @book' do
        expect(assigns(:book)).to eq(book)
      end

      it 'assign the requested user to @user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'update book after create post' do
        book.reload
        expect(book.status).to eq('reading')
        expect(book.user_id).to eq(user.id)
      end
    end

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new post in the database' do
        expect { do_request(request_params) }
          .to change(Post, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'return :unprocessable_entity' do
        do_request(request_invalid_params)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not save new post in the database' do
        expect { do_request(request_invalid_params) }
          .to_not change(Post, :count)
      end
    end
  end

  describe 'PATCH #close_reading_post' do
    before do
      Rails.application.routes.draw do
        patch :readed, to: 'posts#close_reading_post'
      end
    end

    let!(:post) { create(:post) }
    let(:book) do
      create(:book, status: 'reading', user_id: user.id, posts: [post])
    end
    let(:request_params) do
      { method: :patch,
        action: :close_reading_post,
        options: { book_id: book.id },
        format: :json }
    end

    before { do_request(request_params) }

    it 'update book' do
      book.reload
      expect(book.status).to eq('available')
      expect(book.user_id).to eq(nil)
    end

    it 'close prev reading post' do
      post.reload
      expect(post.active).to eq(false)
      expect(post.end_date).to_not eq(nil)
    end
  end
end
# rubocop:enable Metrics/BlockLength