class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string  :name
      t.text    :description
      t.integer :primary_muscle_group_id
      t.integer :user_id
      t.hstore  :fields

      t.timestamps
    end
  end
end
