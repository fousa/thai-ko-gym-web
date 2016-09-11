require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
    create :user
    visit presences_path
  end

  it 'should get an overview of presences' do
    expect(page).to have_css('.calendar')
  end
end
