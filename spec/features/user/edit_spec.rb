require 'rails_helper.rb'

describe 'edit', type: :feature do
  before do
    login_as_user
    @edit_user = create(:user)
    visit edit_user_path(@edit_user)
  end

  it 'should get an edit user form' do
    expect(page).to have_css('.edit_user', count: 1)
  end

  it 'should edit a new user' do
    fill_in 'user_first_name', with: 'Jake'
    within first('.portlet') do
      click_button 'Lid bijwerken'
    end

    expect(page).to have_content('is succesvol gewijzigd.')
    expect(User.find(@edit_user.id).first_name).to eq('Jake')
  end

  it 'should fail to edit a new user' do
    fill_in 'user_first_name', with: ''
    within first('.portlet') do
      click_button 'Lid bijwerken'
    end

    expect(page).to have_content('Onderstaand formulier bevat (verschillende) fouten.')
  end
end
