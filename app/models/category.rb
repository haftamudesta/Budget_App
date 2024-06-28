class Category < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :expense_categories, dependent: :destroy
  has_many :expenses, through: :expense_categories
  validates :name, :icon, presence: true

  def total_expense_category
    expenses.sum(:amount)
  end
end
