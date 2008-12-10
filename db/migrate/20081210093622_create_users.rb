class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :facebook_id, :limit => 20, :null => false
      t.string :session_key
      t.integer :house_id
      t.timestamps
    end
    add_index :users, :facebook_id
  end

  def self.down
    remove_index :users, :facebook_id
    drop_table :users
  end
end
