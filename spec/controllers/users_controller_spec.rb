require 'rails_helper'

RSpec.describe Users::IndexController, type: :controller do
  before { login(create(:user, admin: 'true')) }

  describe 'GET #index' do
    let(:users) { create_list(:user, 5) }
    let(:request_params) { { method: :get, action: :index, format: :json } }

    it 'return 2xx' do
      do_request(request_params)
      expect(response).to have_http_status(:success)
    end

    it 'populates an array of all users' do
      do_request(request_params)
      # expect(assigns(:users)).to match_array(users)
    end
  end

  describe 'GET #current_user' do
    let(:request_params) { { method: :get, action: :me, format: :json } }

    it 'return 2xx' do
      do_request(request_params)
      expect(response).to have_http_status(:success)
    end

    it 'return current user' do
      # expect(subject.current_user).to eq user
    end
  end

  describe 'POST #create' do
    let!(:user) { attributes_for(:user) }
    let(:request_params) { { method: :post, action: :create, options: user, format: :json } }

    context 'with valid attributes' do
      it 'return :created' do
        do_request(request_params)
        expect(response).to have_http_status(:created)
      end

      it 'save new user in the database' do
        expect { post :create, params: user, format: :js }.to change(User, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user) { create(:user) }

    it 'return :success' do
      delete :destroy, params: { id: user }
      expect(response).to have_http_status(:success)
    end

    it 'deletes the user' do
      expect { delete :destroy, params: { id: user } }.to change(User, :count).by(-1)
    end
  end

  describe 'PATCH #update' do
    let(:user) { create(:user) }

    context 'with valid attributes' do
      it 'assigns the requested user to @user' do
        patch :update, params: { id: user.id, user: attributes_for(:user) }, format: :js
        expect(assigns(:user)).to eq(user)
      end

      it 'changes user attributes' do
        patch :update, params: { id: user,
                                 user: {
                                        first_name: 'new_first_name',
                                        last_name: 'new_last_name',
                                        email: 'new_eamil@test.com'
                                        }
                                              }, format: :js
        user.reload

        expect(user.first_name).to eq('new_first_name')
        expect(user.last_name).to eq('new_last_name')
        expect(user.email).to eq('new_eamil@test.com')
      end
    end

    context 'with invalid attributes' do
      #
    end
  end
end
