#Q-1. 在自己的 github repo (rails) 裡，發送一條 PR，讓該 rails app 可以成功執行 cap deploy
  1. 此 rails Gemfile 必須包含以下 gem
      - mini_magick(用paperclip取代)
      - pg
      - redis
      - nokogiri
  2. 可再 app 根目錄下附上一份 deploy.md 說明 server 端做了哪些設定與軟體安裝，需要指令的 SOP
  3. 建議可以用自己的期末作業來當範本
  4. host 在 nginx 的設定裡為 myapp.com


##送PR後自動deploy
安裝hub
	brew indtall hub
修改~/bash_profile
```bash
function pr_and_deploy(){
	hub pull-request -b HEROGWP:"master" -h HEROGWP:`git rev-parse --abbrev-ref HEAD`;
	cap deploy production;
}
```



##安裝圖片壓縮
```
	sudo apt-get install imagemagick
```	

##安裝postgresql

你也可以選擇安裝PostgreSQL：
```	
	sudo apt-get install postgresql libpq-dev postgresql-contrib
```
修改帳號 postgres 的密碼
```	
	sudo -u postgres psql 然後打 \password
```
建資料庫
```
	sudo -u postgres createdb your_database_name
```

##安裝redis
```	
	sudo apt-get install redis-server
```
升級 Rails5 並使用 gem "puma"

修改rails config/environments/production.rb 加上 production 網址
```ruby
config.action_cable.allowed_request_origins = ["https://foo.com"]
```

修改rails route.rb
```ruby
mount ActionCable.server => '/cable'
```
修改 app/assets/javascripts/application.js 要載入 cable.js


修改config/cable.yml'
```ruby
production:
  adapter: redis
  url: redis://redis.example.com:6379

local: &local
  adapter: redis
  url: redis://localhost:6379

development: *local
test: *local
```

修改rails deploy.rb 
```ruby
append :linked_files, 'config/database.yml', 'config/secrets.yml', 'config/cable.yml'
```
修改server /etc/nginx/sites-enabled/contact_system.conf
```conf
server {
  listen 80;
  server_name foo.com;
  root /path-to-your-app/public;
  passenger_enabled on;

  ### INSERT THIS!!! ###
  location /cable {
      passenger_app_group_name contact_system_action_cable;
      passenger_force_max_concurrent_requests_per_process 0;
  }
  .....
}
```


#Q-2. 假設你成功完成上述的項目，但在沒有買網址的情況下，要怎麼讓某一台電腦可以用 myapp.com (http://myapp.com/) 連到你架好的 server ? 
##設定domain 指向 IP
修改/etc/hosts
```
	sudo vi /etc/hosts
```
新增
```
	103.29.69.230   myapp.com
```