require 'rails_helper.rb'

describe 'overview', type: :feature do
  before do
    login_as_user
    create :presence, present_at: '2016-10-01'
  end

  it 'should download an xls with presences for a day' do
    visit day_path('2016-10-01')
    click_link 'xls'

    expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
  end
end
