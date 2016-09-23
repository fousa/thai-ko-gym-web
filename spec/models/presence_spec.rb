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
    it { should validate_uniqueness_of(:present_at).scoped_to(:user_id) }

    it 'should have a valid factory' do
      expect(create(:presence).valid?).to be_truthy
    end

    it 'should be a duplicate' do
      user = create(:user)

      first_presence = create(:presence, user: user, present_at: Date.parse('2016-09-20'))
      expect(first_presence.duplicate?).to be_falsy

      second_presence = build(:presence, user: user, present_at: Date.parse('2016-09-20'))
      second_presence.valid?
      expect(second_presence.duplicate?).to be_truthy
    end
  end

  context 'scopes' do
    it 'should return the monthly presences' do
      create(:presence, present_at: Date.parse('2016-09-20'))
      create(:presence, present_at: Date.parse('2016-09-21'))
      create(:presence, present_at: Date.parse('2016-10-20'))

      expect(Presence.for_month(Date.parse('2016-09-20')).count).to eq(2)
    end

    it 'should return the daily presences' do
      create(:presence, present_at: Date.parse('2016-09-20'))
      create(:presence, present_at: Date.parse('2016-09-20'))
      create(:presence, present_at: Date.parse('2016-10-20'))

      expect(Presence.for_day(Date.parse('2016-09-20')).count).to eq(2)
    end
  end
end
