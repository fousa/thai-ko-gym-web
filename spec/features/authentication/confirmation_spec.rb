require 'rails_helper.rb'

describe 'confirm account', type: :feature do
  before do
    clear_emails

    @user = create(:user, email: 'jake@snake.be', role: :teacher)
    @user.send_confirmation_instructions

    open_email('jake@snake.be')
  end

  it 'should confirm a user' do
    current_email.click_link 'Activeer account'
    expect(page).to have_content('Account bevestigen')

    fill_in 'Wachtwoord', with: '123123123', match: :prefer_exact
    fill_in 'Bevestig wachtwoord', with: '123123123', match: :prefer_exact
    click_button 'Bevestig account'

    expect(page).to have_content('Je account is bevestigd')
    expect(User.first.confirmed_at).to_not be_nil
  end

  it 'should fail to confirm a user' do
    current_email.click_link 'Activeer account'
    expect(page).to have_content('Account bevestigen')

    click_button 'Bevestig account'

    expect(page).to have_content('Account bevestigen')
    expect(User.first.confirmed_at).to be_nil
  end

  private

  def show_reset_path
    visit root_path
    click_link 'Wachtwoord vergeten?'
  end
end
