require 'rails_helper.rb'

describe 'create', type: :feature do
  before do
    login_as_user
    visit new_user_path
  end

  it 'should get a new user form' do
    expect(page).to have_css('.new_user', count: 1)
  end

  it 'should create a new user' do
    fill_in 'user_first_name', with: 'Jake'
    fill_in 'user_last_name', with: 'Snake'
    select 'Man', from: 'user_sex'
    within first('.portlet') do
      click_button 'Lid toevoegen'
    end

    expect(page).to have_content('is succesvol aangemaakt.')
    expect(User.count).to eq(2)
  end

  it 'should fail to create a new user' do
    within first('.portlet') do
      click_button 'Lid toevoegen'
    end

    expect(page).to have_content('Onderstaand formulier bevat (verschillende) fouten.')
    expect(User.count).to eq(1)
  end
end
