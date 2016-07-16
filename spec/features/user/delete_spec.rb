require 'rails_helper.rb'

describe 'delete', type: :feature do
  before do
    login_as_user
    create :user
    visit users_path
  end

  it 'should delete a user' do
    expect { click_link 'Verwijder' }.to change(User, :count).by(-1)
  end
end
