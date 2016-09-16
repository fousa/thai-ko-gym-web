require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
    create :user
    create :presence, present_at: '2016-10-01'
  end

  it 'should get an overview of presences' do
    visit day_path('2016-10-01')
    expect(page).to have_css('.day')
  end
end
