require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before { get :new }
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders new pages' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      post :create, params: { user: { name: '',
                                         email: 'sample@example.com',
                                         password: 'P@ssw0rd' } }
    end
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
    it 'renders new pages' do
      expect(response).to render_template :new
    end
  end
end
