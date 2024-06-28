require 'rails_helper'

RSpec.feature 'Expenses', type: :feature do
  describe('Home Page') do
    it('should show the sign in form') do
      visit root_path
      expect(page).to have_text('Budget App')
      expect(page).to have_text('Log in')
      expect(page).to have_link('Login')
      expect(page).to have_button('Log in')
      expect(page).to have_link('Sign up')
      expect(page).to have_link('Forgot your password?')
      expect(page).to_not have_text('List of Expenses')
    end
  end
  describe('New Expense') do
    it('should redirect to create Expense Page when Create New Expense is clicked') do
      user = User.create(
        name: 'haftamu',
        email: 'haftamu1@gmail.com',
        password: 'test@1234',
        role: 'Admin'
      )
      visit root_path
      fill_in 'user_email', with: user.email # user_email is id of the email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      click_link 'Create New Expense'
      expect(page).to have_current_path('/expenses/new')
      expect(page).to have_text('New Expense')
      expect(page).to have_text('Name')
      expect(page).to have_text('Category')
      expect(page).to have_link('Back to expenses')
      expect(page).to have_button('Create Expense')
    end
  end
end
