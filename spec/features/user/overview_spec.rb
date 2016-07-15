require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
  end

  it 'should get an overview of users' do
    create :user
    visit users_path

    expect(page).to have_css('tbody tr', count: 2)
  end

  it 'should no be able to see the destroy link for the current user' do
    create :user
    visit users_path

    expect(page).to have_css('tbody tr', count: 2)
    expect(page).to have_css('tbody tr a.red', count: 1)
  end
end
