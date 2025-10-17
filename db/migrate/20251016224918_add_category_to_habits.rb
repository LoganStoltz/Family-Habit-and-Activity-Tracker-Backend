class AddCategoryToHabits < ActiveRecord::Migration[8.0]
  def change
    add_column :habits, :category, :string
  end
end
