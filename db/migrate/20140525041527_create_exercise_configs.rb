class CreateExerciseConfigs < ActiveRecord::Migration
  def change
    create_table :exercise_configs do |t|
      t.integer :user_id
      t.integer :workout_id
      t.integer :exercise_id
      t.hstore  :config

      t.timestamps
    end
  end
end
