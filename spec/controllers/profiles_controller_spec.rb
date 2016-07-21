require 'rails_helper'

describe ProfilesController do
  before { bypass_rescue }

  context 'Not authenticated' do
    let(:user) { create(:user) }

    it { should redirect_for_login { get :show } }
    it { should redirect_for_login { get :edit } }
    it { should redirect_for_login { put :update } }
  end

  context 'Authenticated' do
    before { sign_in create(:user) }
    let(:user) { create(:user) }

    it { should render_template_name('edit') { get :show } }
    it { should render_template_name('edit') { get :edit } }
    it { should render_template_name('edit') { put :update, params: { user: { first_name: nil } } } }
  end

  context 'Strong params' do
    before { sign_in create(:user) }
    let(:user) { create(:user) }

    it { should permit(:first_name, :email, :last_name, :sex, :birth_date, :phone, :password, :password_confirmation, :address, :postalcode, :city, :country).for(:update, params: { user: { first_name: '' } }).on(:user) }
  end
end
