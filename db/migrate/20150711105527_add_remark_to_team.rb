class AddRemarkToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :remark, :text
  end
end
