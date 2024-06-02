class CreateExpenseCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_categories do |t|
      t.belongs_to :expense, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
