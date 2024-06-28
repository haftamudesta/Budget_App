require 'rails_helper'

RSpec.describe Expense, type: :model do
  context 'when creating a expense without valid author' do
    let(:expense) {build :expense}
    let(:expense1) {build :expense}
  
    it 'should not be a valid expense without valid author ' do
      expect(expense.valid?).to eq(false)
      expect(expense.name).to eq("Apple")
      expect(expense.amount).to eq(4)
    end
     it 'should not be saved to database without valid author' do
      expect(expense1.save).to eq(false)
      expect{expense1.save!}.to raise_error(ActiveRecord::RecordInvalid)
     end
  end

  context 'when creating a expense with valid author' do
    
    let!(:user) {create :user}
    let(:expense) {build :expense,author_id: user.id}
    let(:expense1) {build :expense, author_id: user.id}
  
    it 'should be a valid expense with a given attirbute' do
      expect(expense.valid?).to eq(true)
      expect(expense.name).to eq("Apple")
      expect(expense.amount).to eq(4)
    end
     it 'should be saved to database with valid author' do
      expect(expense1.save).to eq(true)
     end
  end
end
