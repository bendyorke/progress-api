class CreateExercisesExerciseFields < ActiveRecord::Migration
  def change
    create_table :exercises_exercise_fields do |t|
      t.integer :exercise_id
      t.integer :exercise_field_id

      t.timestamps
    end
  end
end
