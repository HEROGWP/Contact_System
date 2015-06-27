class AddContactsCountToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :contact_team_count, :integer, :default => 0
    add_column :teams, :adjustment, :integer, :default => 0
  end
end
