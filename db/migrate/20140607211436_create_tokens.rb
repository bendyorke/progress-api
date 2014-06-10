class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string  :hex,       null: false
      t.integer :active, default: 1
      t.integer :user_id

      t.timestamps
    end

    add_index :tokens, :hex, unique: true
  end
end
