require 'rails_helper'

describe Presence do
  context 'Relations' do
    it { should belong_to(:user) }
    it { should belong_to(:registered_by) }
  end

  context 'Validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:present_at) }
    it { should validate_presence_of(:registered_by) }

    it 'should have a valid factory' do
      expect(create(:presence).valid?).to be_truthy
    end
  end
end
