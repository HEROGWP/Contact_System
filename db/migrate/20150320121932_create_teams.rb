class CreateTeams < ActiveRecord::Migration
  def up
    create_table :teams do |t|
      t.date :when
      t.text :numbers

      t.timestamps null: false
    end
  end

  def down
  	drop_table :teams
  end
end
