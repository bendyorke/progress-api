class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.string  :name
      t.text    :description
      t.integer :user_id
      t.integer :workout_id

      t.timestamps
    end
  end
end
