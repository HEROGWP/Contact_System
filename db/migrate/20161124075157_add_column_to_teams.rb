class AddColumnToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :year, :integer
  	add_column :teams, :month, :integer
  	add_index :teams, :year
  	add_index :teams, :month


  	Team.all.each do |team|
  		team.update(year: team.when.year, month: team.when.month) if team.when
  	end
  end
end
