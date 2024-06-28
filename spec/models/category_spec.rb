require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'when creating a category without valid author' do
    let(:category) {build :category}
    let(:category1) {build :category}
  
    it 'should not be a valid category without valid author ' do
      expect(category.valid?).to eq(false)
      expect(category.name).to eq("Fruit")
      expect(category.icon).to eq("icon 1")
    end
     it 'should not be saved to database without valid author' do
      expect(category1.save).to eq(false)
      expect{category1.save!}.to raise_error(ActiveRecord::RecordInvalid)
     end
  end

  context 'when creating a category with valid author' do
    
    let!(:user) {create :user}
    let(:category) {build :category,author_id: user.id}
    let(:category1) {build :category, author_id: user.id}
  
    it 'should be a valid category with a given attirbute' do
      expect(category.valid?).to eq(true)
      expect(category.name).to eq("Fruit")
      expect(category.icon).to eq("icon 1")
    end
     it 'should be saved to database with valid author' do
      expect(category1.save).to eq(true)
     end
  end
end
