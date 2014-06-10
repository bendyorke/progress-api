class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string  :strategy
      t.integer :user_id
      t.hstore  :authorization

      t.timestamps
    end
  end
end
