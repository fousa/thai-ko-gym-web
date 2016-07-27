require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
    create :user, active: true
    create :user
  end

  it 'should download an xls with all users' do
    visit users_path
    click_link 'xls'

    expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
  end

  it 'should download an xls with all active users' do
    visit active_users_path
    click_link 'xls'

    expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
  end

  it 'should download an xls with all inactive users' do
    visit inactive_users_path
    click_link 'xls'

    expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
  end
end
