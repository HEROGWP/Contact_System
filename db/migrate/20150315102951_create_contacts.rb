class CreateContacts < ActiveRecord::Migration
  def up
    create_table :contacts do |t|
      t.string :name
      t.date :birthday
      t.string :phone
      t.string :address
      t.text :remark

      t.timestamps null: false
    end
  end

  def down
    drop_table :contacts
  end
end
