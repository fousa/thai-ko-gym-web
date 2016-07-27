require 'rails_helper.rb'

describe 'profile', type: :feature do
  before do
    login_as_user
    visit profile_path
  end

  it 'should show the profile' do
    expect(page).to have_content('Profiel aanpassen')
  end

  it 'should edit the profile' do
    fill_in 'Voornaam', with: 'Jake'
    click_button 'Profiel aanpassen'

    expect(page).to have_content('Jouw profiel is succesvol gewijzigd')
    expect(User.first.first_name).to eq('Jake')
  end

  it 'should fail to edit the profile' do
    fill_in 'Voornaam', with: ''
    click_button 'Profiel aanpassen'

    expect(page).to have_content('Onderstaand formulier bevat (verschillende) fouten')
  end

  it 'should edit the password' do
    fill_in 'Huidig wachtwoord', with: '123123123'
    fill_in 'Wachtwoord', with: '123123'
    fill_in 'Wachtwoord bevestiging', with: '123123'
    click_button 'Wachtwoord wijzigen'

    expect(page).to have_content('Jouw profiel is succesvol gewijzigd')
  end

  it 'should fail to edit the password without current password' do
    fill_in 'Wachtwoord', with: '123123'
    fill_in 'Wachtwoord bevestiging', with: '123123'
    click_button 'Wachtwoord wijzigen'

    expect(page).to have_content('Onderstaand formulier bevat (verschillende) fouten')
  end

  it 'should fail to edit the password' do
    fill_in 'Huidig wachtwoord', with: '123123123'
    fill_in 'Wachtwoord', with: '123'
    click_button 'Wachtwoord wijzigen'

    expect(page).to have_content('Onderstaand formulier bevat (verschillende) fouten')
  end
end
