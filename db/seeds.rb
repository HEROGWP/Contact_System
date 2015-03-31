# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


puts 'Hello World!'
puts "這個種子檔會自動建立一個帳號, 並且創建30個名單,30個點名表"

create_account = User.create([email: 'test@gmail.com', password: '12345678', password_confirmation: '12345678', name: '測試用帳號'])

create_contacts = for i in 1..30 do
                   Contact.create!([name: "蔡建弘#{i}", birthday: "#{Date.today+(i*15)}", user_id: "1"])
                  end
create_teams =    for k in 1..30 do
                    Team.create!([when: "#{Date.today+i+(k*15)}", user_id: "1"])
                  end