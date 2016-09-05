require 'rails_helper'

describe Api::UsersController do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  before(:each) do
    create(:user, active: false)
    create(:user, active: true)
  end

  context 'index' do
    it 'should return a 401 error when no credentials are given' do
      get :index, format: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should return users when a token is given' do
      token = JsonWebToken.encode user_id: user.id
      add_token_authentication_header token

      get :index, format: 'json'
      expect(response).to have_http_status(:success)
      expect(json.count).to eq(3)
    end
  end

  context 'active' do
    it 'should return a 401 error when no credentials are given' do
      get :active, format: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'should return active users when a token is given' do
      token = JsonWebToken.encode user_id: user.id
      add_token_authentication_header token

      get :active, format: :json
      expect(response).to have_http_status(:success)
      expect(json.count).to eq(1)
    end
  end
end
