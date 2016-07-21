require 'rails_helper'

describe UsersController do
  before { bypass_rescue }

  context 'Not authenticated' do
    let(:user) { create(:user) }

    it { should redirect_for_login { get :index } }
    it { should redirect_for_login { get :new } }
    it { should redirect_for_login { post :create } }
    it { should redirect_for_login { get :show, params: { id: user.id } } }
    it { should redirect_for_login { get :edit, params: { id: user.id } } }
    it { should redirect_for_login { put :update, params: { id: user.id } } }
    it { should redirect_for_login { delete :destroy, params: { id: user.id } } }
  end

  context 'Authenticated' do
    before { sign_in create(:user) }
    let(:user) { create(:user) }

    it { should render_template_name('index') { get :index } }
    it { should render_template_name('new') { get :new } }
    it { should redirect_to_path(edit_user_path(user.id)) { get :show, params: { id: user.id } } }
    it { should render_template_name('edit') { get :edit, params: { id: user.id } } }

    it { should render_template_name('new') { post :create, params: { user: { first_name: nil } } } }
    it { should render_template_name('edit') { put :update, params: { id: user.id, user: { first_name: nil } } } }

    # it { should redirect_to_path(new_user_path) { post :create, params: { user: { last_name: '' } } } }
    # it { should redirect_to_path(edit_pilot_path(user)) { put :update, params: { id: user.id, user: { first_name: Faker::Name.name } } } }
    # it { should redirect_to_path(users_path) { delete :destroy, params: { id: user.id } } }
  end

  context 'Strong params' do
    before { sign_in create(:user) }
    let(:user) { create(:user) }

    it { should permit(:first_name, :email, :role, :last_name, :sex, :birth_date, :category, :type, :rankings, :phone_number, :active, :comments, :address, :postalcode, :city, :country).for(:create, params: { user: { first_name: '' } }).on(:user) }
    it { should permit(:first_name, :email, :role, :last_name, :sex, :birth_date, :category, :type, :rankings, :phone_number, :active, :comments, :address, :postalcode, :city, :country).for(:update, params: { id: user.id, user: { first_name: '' } }).on(:user) }
  end
end
