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

    it { should permit(:first_name, :email, :last_name, :sex, :birth_date, :phone_number, :address, :postalcode, :city, :country).for(:update, params: { user: { first_name: '' } }).on(:user) }
    it { should permit(:password, :password_confirmation, :current_password).for(:update_password, verb: :patch, params: { user: { password: '' } }).on(:user) }
  end
end
