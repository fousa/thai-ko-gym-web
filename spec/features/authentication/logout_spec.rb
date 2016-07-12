require 'rails_helper.rb'

describe 'logout', type: :feature do
  before do
    login_as_user
    visit root_path
  end

  it 'should log out' do
    click_link 'Uitloggen'

    expect(page).to have_content('Inloggen')
  end
end
