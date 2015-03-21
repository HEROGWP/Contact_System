class AddContactIdsToTeam < ActiveRecord::Migration
  def up
  	add_column :teams, :contact_id, :integer
  end

  def down
  	remove_column :teams, :contact_id
  end
end
