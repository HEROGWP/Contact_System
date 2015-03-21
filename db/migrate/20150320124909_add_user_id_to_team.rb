class AddUserIdToTeam < ActiveRecord::Migration
  def up
  	add_column :teams, :user_id, :integer
  end

  def down
  	remove_column :teams, :user_id
  end
end
