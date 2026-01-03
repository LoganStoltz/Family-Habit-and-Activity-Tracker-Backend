class CreateMilestones < ActiveRecord::Migration[7.0]
  def change
    create_table :milestones do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :title, null: false
      t.string :category
      t.datetime :occurred_at, null: false
      t.string :mood
      t.text :notes
      t.text :tags
      t.boolean :favorite, default: false, null: false

      t.timestamps
    end

    add_index :milestones, :occurred_at
    add_index :milestones, [ :profile_id, :category ]
    add_index :milestones, [ :profile_id, :favorite ]
  end
end
