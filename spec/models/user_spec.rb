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
end
