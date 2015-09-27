class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users  do |t|
      t.string :email, null: false, default: ""
      t.integer :role, null: false, default: 0
      t.string :token, null: false

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :token,                unique: true
    add_index :users, :role
  end
end
