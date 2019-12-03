require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before { login(create(:user)) }

  describe 'GET #index' do
    let(:books) { create_list(:book, 5) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'return 2xx' do
      do_request(request_params)
      expect(response).to have_http_status(:success)
    end

    it 'populates an array of all books' do
      do_request(request_params)
      # expect(assigns(:books)).to match_array(books)
    end
  end

  describe 'POST #create' do
    before { login(create(:user)) }
    let!(:book) { attributes_for(:book) }
    let(:request_params) { { method: :post, action: :create, options: book, format: :json } }

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new book in the database' do
        expect { post :create, params: book, format: :js }.to change(Book, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(create(:user)) }
    let!(:book) { create(:book) }

    it 'return :success' do
      delete :destroy, params: { id: book }
      expect(response).to have_http_status(:success)
    end

    it 'deletes the book' do
      expect { delete :destroy, params: { id: book } }.to change(Book, :count).by(-1)
    end
  end

  describe 'GET #show' do
    before do
      login(create(:user))
      get :show, params: { id: book.id }
    end
    let!(:book) { create(:book) }

    it 'return 2xx' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested book to @book' do
      expect(assigns(:book)).to eq(book)
    end
  end

  describe 'PATCH #update' do
    before { login(create(:user)) }
    let!(:book) { create(:book) }

    context 'with valid attributes' do
      it 'assigns the requested book to @book' do
        patch :update, params: { id: book.id, book: attributes_for(:book) }, format: :js
        expect(assigns(:book)).to eq(book)
      end

      it 'changes book attributes' do
        patch :update, params: { id: book.id, book: { title: 'new_title', author: 'new_author' } }, format: :js
        book.reload

        expect(book.title).to eq('new_title')
        expect(book.author).to eq('new_author')
      end
    end

    context 'with invalid attributes' do
      #
    end
  end
end
