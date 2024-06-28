class Expense < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :expense_categories, dependent: :destroy
  has_many :categories, through: :expense_categories
  validates :name, :amount, presence:true
end
