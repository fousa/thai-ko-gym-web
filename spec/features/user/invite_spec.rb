require 'rails_helper.rb'

describe 'invite', type: :feature do
  before do
    login_as_user
    clear_emails
  end

  it 'should not see the invite button' do
    @edit_user = create(:user)
    visit edit_user_path(@edit_user)

    expect(page).not_to have_content('Stuur uitnodiging')
  end

  it 'should see the invite button' do
    @edit_user = create(:user, email: 'a@b.be')
    visit edit_user_path(@edit_user)

    expect(page).to have_content('STUUR UITNODIGING')
  end

  it 'should get an invitation email' do
    @edit_user = create(:user, email: 'a@b.be')
    visit edit_user_path(@edit_user)
    within first('.portlet') do
      click_link 'STUUR UITNODIGING'
    end

    open_email(@edit_user.email)
    expect(current_email).to have_content('Activeer account')
  end
end
