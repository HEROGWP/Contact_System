class RemoveContactIdToContact < ActiveRecord::Migration
  def change
  	remove_column :contacts, :contact_id
  end
end
