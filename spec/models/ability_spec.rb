require 'rails_helper'
require 'cancan/matchers'

describe User do
  context 'Member' do
    subject(:ability) { Ability.new(user) }
    let(:user) { create(:user, role: :member) }

    it { should_not be_able_to(:login, User.new) }
    it { should_not be_able_to(:read, User.new) }
    it { should_not be_able_to(:active, User.new) }
    it { should_not be_able_to(:inactive, User.new) }
    it { should_not be_able_to(:manage, User.new) }

    it { should_not be_able_to(:read, Presence.new) }
    it { should_not be_able_to(:manage, Presence.new) }
  end

  context 'Teacher' do
    subject(:ability) { Ability.new(user) }
    let(:user) { create(:user, role: :teacher) }

    it { should be_able_to(:login, User.new) }
    it { should be_able_to(:read, User.new) }
    it { should be_able_to(:active, User.new) }
    it { should be_able_to(:inactive, User.new) }
    it { should_not be_able_to(:manage, User.new) }

    it { should be_able_to(:read, Presence.new) }
    it { should be_able_to(:create, Presence.new) }
    it { should_not be_able_to(:manage, Presence.new) }
  end

  context 'Administrator' do
    subject(:ability) { Ability.new(user) }
    let(:user) { create(:user, role: :admin) }

    it { should be_able_to(:login, User.new) }
    it { should be_able_to(:read, User.new) }
    it { should be_able_to(:active, User.new) }
    it { should be_able_to(:inactive, User.new) }
    it { should be_able_to(:manage, User.new) }

    it { should be_able_to(:read, Presence.new) }
    it { should be_able_to(:manage, Presence.new) }
  end
end
