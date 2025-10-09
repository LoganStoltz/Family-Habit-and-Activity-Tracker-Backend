class CreateCompletedHabits < ActiveRecord::Migration[8.0]
  def change
    create_table :completed_habits do |t|
      t.bigint :habit_id
      t.datetime :created_at, precision: 6, null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :date_completed, precision: 6

      t.index :habit_id
      t.foreign_key :habits, column: :habit_id
    end
  end
end