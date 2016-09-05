require 'rails_helper'

describe Api::AuthenticationController do
  let(:user) { create(:user, email: 'jake@snake.be', password: '123123123', password_confirmation: '123123123') }

  it 'should return a 401 error when no credentials are given' do
    post :create
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should return a 401 error when incorrect credentials are given' do
    add_authentication_header 'some@some.some', '123123123'

    post :create, {}
    expect(response).to have_http_status(:unauthorized)
  end

  it 'should return a token when correct credentials are given' do
    add_authentication_header user.email, '123123123'

    post :create, {}
    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body)).to have_key('auth_token')
  end
end
