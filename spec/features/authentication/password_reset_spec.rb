require 'rails_helper.rb'

describe 'password reset', type: :feature do
  before do
    @user = create(:user)

    clear_emails
    show_reset_path
  end

  it 'should send reset instructions' do
    fill_in 'E-mailadres', with: @user.email
    click_button 'Stuur herstel instructies'

    expect(page).to have_content('Inloggen')

    open_email(@user.email)
    expect(current_email).to have_content('Wachtwoord wijzigen')
  end

  it 'should fail to send reset instructions' do
    fill_in 'E-mailadres', with: 'jake@snake.be'
    click_button 'Stuur herstel instructies'

    expect(page).to have_content('E-mailadres niet gevonden')
    expect(current_email).to be_nil
  end

  private

  def show_reset_path
    visit root_path
    click_link 'Wachtwoord vergeten?'
  end
end
