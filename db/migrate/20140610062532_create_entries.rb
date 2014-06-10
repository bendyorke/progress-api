class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.integer :workout_id
      t.integer :exercise_id
      t.integer :user_id
      t.hstore  :data

      t.timestamps
    end
  end
end
