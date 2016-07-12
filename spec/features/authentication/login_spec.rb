require 'rails_helper.rb'

describe 'login', type: :feature do
  before do
    @user = create(:user, password: '123123123', password_confirmation: '123123123')

    visit root_path
  end

  it 'should login' do
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: '123123123'
    click_button 'Inloggen'

    expect(page).to have_content('Uitloggen')
  end

  it 'should fail to login' do
    fill_in 'user_email', with: 'jake@snake.be'
    fill_in 'user_password', with: '123123123'
    click_button 'Inloggen'

    expect(page).to have_content('Ongeldig e-mail of wachtwoord')
  end
end
