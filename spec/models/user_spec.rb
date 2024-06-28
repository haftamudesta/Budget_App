require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when creating a user' do
    let(:user) { build :user }
    let(:user1) { create :user, name: nil }

    let(:user2) { build :user, email: user.email, role: user.role }
    it 'should be a valid user with all attirbute' do
      # user.valid? == true
      expect(user.valid?).to eq(true)
    end
    it 'should raise an error for duplicated email' do
      user.save
      expect(user2.save).to eq(false)
      # expect(user2.save!).to raise_error(ActiveRecord::RecordInvalid) will not work as it is not the correct way of saving to database
      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
