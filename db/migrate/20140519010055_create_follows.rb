class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :followable_id
      t.string  :followable_type
      t.integer :user_id
      t.hstore  :config

      t.timestamps
    end
  end
end
