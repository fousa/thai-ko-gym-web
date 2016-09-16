require 'rails_helper'

describe DaysController do
  before { bypass_rescue }

  context 'Not authenticated' do
    let(:presence) { create(:presence) }

    it { should redirect_for_login { get :show, params: { id: '2016-09-01' } } }
  end

  context 'Authenticated' do
    before { sign_in create(:user, role: :admin) }
    let(:presence) { create(:presence) }

    it { should render_template_name('show') { get :show, params: { id: '2016-09-01' } } }
  end

  context 'teacher role' do
    before { sign_in create(:user, role: :teacher) }
    let(:presence) { create(:presence) }

    it { should render_template_name('show') { get :show, params: { id: '2016-09-01' } } }
  end

  context 'member role' do
    before { sign_in create(:user, role: :member) }
    let(:presence) { create(:presence) }

    it { expect { get :show, params: { id: '2016-09-01' } }.to raise_exception(CanCan::AccessDenied) }
  end
end
