class CreateExercisesMuscleGroups < ActiveRecord::Migration
  def change
    create_table :exercises_muscle_groups do |t|
      t.integer :exercise_id
      t.integer :muscle_group_id

      t.timestamps
    end
  end
end
