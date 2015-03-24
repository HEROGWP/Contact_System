class AddMonthToContact < ActiveRecord::Migration
  def up
  	add_column :contacts, :month, :integer
  end

  def down
  	remove_column :contacts, :month
  end
end
