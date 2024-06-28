require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
  let(:user) { create :user }
  before(:each) do
    sign_in(user)
  end
  describe 'GET expenses' do
    it 'should return http status code 200' do
      get expenses_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'Create expense' do
    it 'should render create new form then save the data to databse' do
      get new_expense_path
      expect(response).to render_template('expenses/_form')

      post expenses_path, params: {
        expense: {
          name: 'Apple',
          amount: 4
        }
      }
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(User.count).to eq(3)
    end
  end
  describe 'Update expense' do
    let(:expense1) { create :expense, author_id: user.id }
    it('should rnder the edit expense form then update the data in to database') do
      get edit_expense_path(expense1)
      expect(response).to render_template('expenses/edit')
      patch expense_path(expense1), params: {
        expense: {
          name: 'Banana',
          amount: 14
        }
      }
      expect(response.media_type).to eq('text/html')
      expect(response.content_type).to eq('text/html; charset=utf-8')
      expect(assigns[:expense].name).to eq('Banana')
    end
  end
end
