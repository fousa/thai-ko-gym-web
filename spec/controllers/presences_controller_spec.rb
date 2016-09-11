require 'rails_helper'

describe PresencesController do
  before { bypass_rescue }

  context 'Not authenticated' do
    let(:presence) { create(:presence) }

    it { should redirect_for_login { get :index } }
  end

  context 'Authenticated' do
    before { sign_in create(:user, role: :admin) }
    let(:presence) { create(:presence) }

    it { should render_template_name('index') { get :index } }
  end

  context 'teacher role' do
    before { sign_in create(:user, role: :teacher) }
    let(:presence) { create(:presence) }

    it { should render_template_name('index') { get :index } }
  end

  context 'member role' do
    before { sign_in create(:user, role: :member) }
    let(:presence) { create(:presence) }

    it { expect { get :index }.to raise_exception(CanCan::AccessDenied) }
  end
end
