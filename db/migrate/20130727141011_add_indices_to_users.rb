class AddIndicesToUsers < ActiveRecord::Migration
  def change
  end
  add_index :users, :name 
  add_index :users, :username, :unique => true
end
