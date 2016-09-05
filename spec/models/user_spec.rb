require 'rails_helper'

describe User do
  context 'Relations' do
    it { should have_many(:presences) }
    it { should have_many(:registered_presences).class_name('Presence').with_foreign_key(:registered_by) }
  end

  context 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:sex) }
    it { should validate_presence_of(:role) }

    it 'should have a valid factory' do
      expect(create(:user).valid?).to be_truthy
    end

    it 'should have a valid factory when confirmed' do
      user = create(:user, confirmed_at: Time.now, email: 'a@b.c')
      expect(user.valid?).to be_truthy
    end
  end

  context 'scopes' do
    it 'should return the active users' do
      create(:user, active: true)
      create(:user, active: true)
      create(:user, active: false)

      expect(User.active.count).to eq(2)
    end

    it 'should return the inactive users' do
      create(:user, active: false)
      create(:user, active: false)
      create(:user, active: true)

      expect(User.inactive.count).to eq(2)
    end
  end

  context 'utilities' do
    it 'should have a correct name' do
      user = create(:user, first_name: 'Jake', last_name: 'Snake')
      expect(user.name).to eq('Jake Snake')
    end

    it 'should have a correct name when no first name' do
      user = build(:user, first_name: nil, last_name: 'Snake')
      expect(user.name).to eq('Snake')
    end

    it 'should have a correct name when no last name' do
      user = build(:user, first_name: 'Jake', last_name: nil)
      expect(user.name).to eq('Jake')
    end

    it 'should have a correct age' do
      user = build(:user, birth_date: Date.parse('1984-06-28'))
      expect(user.age).to eq(32)
    end

    it 'should have a correct age when no birth date' do
      user = build(:user, birth_date: nil)
      expect(user.age).to be_nil
    end
  end
end
