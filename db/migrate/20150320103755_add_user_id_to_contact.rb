class AddUserIdToContact < ActiveRecord::Migration
  def up
  	add_column :contacts, :user_id, :integer
  end
  def down
  	remove_column :contacts, :user_id
  end
end
