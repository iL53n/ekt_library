require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  before { login(create(:user)) }

  describe 'GET #index' do
    let(:books) { create_list(:book, 5) }

    before { get :index }

    it 'return 2xx' do
      expect(response).to have_http_status(:success)
    end

    it 'populates an array of all books' do
      expect(assigns(:books)).to match_array(books)
    end
  end
end
