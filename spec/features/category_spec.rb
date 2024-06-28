require 'rails_helper'

RSpec.feature 'Categories', type: :feature do
  describe('Category Page') do
    before :each do
      user = User.create(
        name: 'haftamu',
        email: 'haftamu1@gmail.com',
        password: 'test@1234',
        role: 'user'
      )
      sign_in(user)
      sleep 1
    end
    it('Should visit Home page') do
      visit root_path
      expect(page).to have_text('Budget App')
      expect(page).to have_link('Categories')
    end
    it('Should visit Cagetgories page') do
      visit root_path
      click_link 'Categories'
      expect(page).to have_current_path('/categories')
      expect(page).to have_text('List of Categories')
      expect(page).to have_link('Create New Category')
    end
    it('Should visit New Cagetgory page') do
      visit root_path
      click_link 'Categories'
      sleep 5
      expect(page).to have_current_path('/categories')
      click_link 'Create New Category'
      sleep 5
      expect(page).to have_current_path('/categories/new')
      expect(page).to have_text('New Category')
      expect(page).to have_text('Name')
      expect(page).to have_text('Icon')
      expect(page).to have_link('Back to Categories')
      expect(page).to have_button('Create Category')
    end
    it('Should not submit an empty form') do
      visit root_path
      click_link 'Categories'
      sleep 5
      expect(page).to have_current_path('/categories')
      click_link 'Create New Category'
      sleep 5
      expect(page).to have_current_path('/categories/new')
      click_button 'Create Category'
      expect(page).to have_text("Name can't be blank")
      expect(page).to have_text("Icon can't be blank")
      expect(page).to have_link('Back to Categories')
      expect(page).to have_button('Create Category')
    end
  end
end
