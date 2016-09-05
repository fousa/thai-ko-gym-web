require 'rails_helper'

describe Api::PresencesController do
  render_views

  let(:json) { JSON.parse(response.body) }
  let(:user) { create(:user) }
  before(:each) do
    @other_user = create(:user)
  end

  it 'should return a 401 error when no credentials are given' do
    post :create, format: :json
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should return a presence when a token is given' do
    token = JsonWebToken.encode user_id: user.id
    add_token_authentication_header token

    post :create, params: { presence: { user_id: @other_user.id, present_at: Date.today }, format: :json }
    expect(response).to have_http_status(:success)
    expect(json['presence']['registered_by']['id']).to eq(user.id)
    expect(json['presence']['user']['id']).to eq(@other_user.id)
  end

  it 'should return a validation error when incorrect data is given' do
    token = JsonWebToken.encode user_id: user.id
    add_token_authentication_header token

    post :create, params: { presence: { present_at: Date.today }, format: :json }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
