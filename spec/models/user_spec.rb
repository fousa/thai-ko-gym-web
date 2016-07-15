require 'rails_helper'

describe User do
  context 'Validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:sex) }

    it 'should have a valid factory' do
      expect(create(:user).valid?).to be_truthy
    end

    it 'should have a valid factory when confirmed' do
      user = create(:user, confirmed_at: Time.now, email: 'a@b.c')
      expect(user.valid?).to be_truthy
    end
  end

  context 'Utilities' do
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
