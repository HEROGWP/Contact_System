class AddNameToUser < ActiveRecord::Migration
  def up
    add_column :users, :name, :string	
  end

  def down
  	remove_colume :users, :name
  end
end
