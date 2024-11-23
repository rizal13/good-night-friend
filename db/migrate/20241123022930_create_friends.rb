class CreateFriends < ActiveRecord::Migration[8.0]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id

      t.timestamps
    end

    add_index :friends, [ :user_id, :friend_id ], unique: true
    add_foreign_key :friends, :users, column: :user_id
    add_foreign_key :friends, :users, column: :friend_id
  end
end
