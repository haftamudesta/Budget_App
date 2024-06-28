require 'rails_helper'

RSpec.feature 'Authentications', type: :feature do
  describe('log in') do
    it('should log in user') do
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
      expect(page).to have_text('Budget App')
      expect(page).to have_button('Log out')
      expect(page).to have_button('All')
      expect(page).to have_link('Expenses')
      expect(page).to have_link('Categories')
      expect(page).to have_text('List of Expenses')
    end
  end
end
