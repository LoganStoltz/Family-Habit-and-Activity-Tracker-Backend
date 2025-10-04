class AddCompletedToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :completed, :boolean, default: false
    add_column :habits, :date_completed, :date
    remove_column :habit_logs, :completed, :boolean
  end
end
