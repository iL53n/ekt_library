require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  before { login(create(:user, admin: 'true')) }

  describe 'GET #index' do
    let!(:categories) { create_list(:category, 5) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'return 2xx' do
      do_request(request_params)
      expect(response).to have_http_status(:success)
    end

    it 'populates an array of all categories' do
      do_request(request_params)
      expect(assigns(:categories)).to match_array(categories)
    end
  end

  describe 'POST #create' do
    let!(:category) { attributes_for(:category) }
    let(:request_params) { { method: :post, action: :create, options: category, format: :json } }

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new category in the database' do
        expect { post :create, params: category, format: :js }.to change(Category, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:category) { create(:category) }

    it 'return :success' do
      delete :destroy, params: { id: category }
      expect(response).to have_http_status(:success)
    end

    it 'deletes the category' do
      expect { delete :destroy, params: { id: category } }.to change(Category, :count).by(-1)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: category.id } }

    let!(:category) { create(:category) }

    it 'return 2xx' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested book to @book' do
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }

    context 'with valid attributes' do
      it 'assigns the requested category to @category' do
        patch :update, params: { id: category, category: attributes_for(:category) }, format: :js
        expect(assigns(:category)).to eq(category)
      end

      it 'changes category attributes' do
        patch :update, params: { id: category,
                                 category: {
                                     title: 'new_title'
                                 }
        }, format: :js
        category.reload

        expect(category.title).to eq('new_title')
      end
    end

    context 'with invalid attributes' do
      #
    end
  end
end
