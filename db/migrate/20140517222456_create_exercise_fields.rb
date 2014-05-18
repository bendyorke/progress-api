class CreateExerciseFields < ActiveRecord::Migration
  def change
    create_table :exercise_fields do |t|
      t.string :name
      t.string :unit

      t.timestamps
    end
  end
end
