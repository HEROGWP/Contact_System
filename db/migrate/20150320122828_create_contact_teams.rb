class CreateContactTeams < ActiveRecord::Migration
  def up
    create_table :contact_teams do |t|
      t.integer :contact_id
      t.integer :team_id

      t.timestamps null: false
    end
  end
  def down
  	drop_table :contact_teams
  end
end
