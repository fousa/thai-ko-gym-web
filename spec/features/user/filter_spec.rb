require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
  end

  it 'should get an overview of active users' do
    create :user, active: true
    create :user
    visit active_users_path
    expect(page).to have_css('tbody tr', count: 1)
  end

  it 'should get an overview of inactive users' do
    create :user, active: true
    create :user, active: false
    visit inactive_users_path
    expect(page).to have_css('tbody tr', count: 2)
  end

  context 'search' do
    it 'should be able to search the users', js: true do
      create(:user, first_name: 'Name', last_name: 'test')
      create(:user, first_name: 'No', last_name: 'test')
      visit users_path

      fill_in 'search', with: 'Na'
      press_enter '#search'

      expect(page).to have_css('tbody tr', count: 1)
    end

    it 'should be able to search the active users', js: true do
      create(:user, first_name: 'Name', last_name: 'test', active: true)
      create(:user, first_name: 'No', last_name: 'test')
      visit active_users_path

      fill_in 'search', with: 'test'
      press_enter '#search'

      expect(page).to have_css('tbody tr', count: 1)
    end

    it 'should be able to search the inactive users', js: true do
      create(:user, first_name: 'Name', last_name: 'test', active: true)
      create(:user, first_name: 'No', last_name: 'test')
      visit inactive_users_path

      fill_in 'search', with: 'test'
      press_enter '#search'

      expect(page).to have_css('tbody tr', count: 1)
    end
  end
end
