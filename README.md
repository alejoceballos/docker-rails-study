Check what is going to a container in case it is up, but you cannot access it:
```
docker logs --tail 50 --follow --timestamps <container>
```

Check port status using PowerShell
```shell script
netstat -aon | findstr '3000'
```

Starting rails server from the Docker container:
```shell script
rails server -b 0.0.0.0
```
or
```shell script
docker exec <container> rails server -b 0.0.0.0
```

Checking all docker volumes 
```shell script
docker volume inspect $(docker volume ls -q)
```

Possible solution for remote debugging:
- https://europepmc.github.io/techblog/rails/2017/11/03/rubymine-remote-debug-rails-in-docker.html
```
rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
```

Completely wipe out your docker doing:
```shell script
docker rm -f $(docker ps -aq)
docker image rm -f $(docker image ls -q)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q)
```

C:\Users\alejo\AppData\Local\JetBrains\IntelliJIdea2020.1\ruby_stubs\-706067037\usr\local\bundle\specifications
C:\Users\alejo\AppData\Local\JetBrains\IntelliJIdea2020.1\ruby_stubs\-706067037\usr\local\bundle\gems
C:\Users\alejo\AppData\Local\JetBrains\IntelliJIdea2020.1\ruby_stubs\-1249202311\usr\local\bundle\specifications
C:\Users\alejo\AppData\Local\JetBrains\IntelliJIdea2020.1\ruby_stubs\-1249202311\usr\local\bundle\gems


#### New Project

```shell script
rails new . --force --no-deps --database=postgresql
```

#### Update DB config

```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: postgres
  # For details on connection pooling, see Rails configuration guide
  # https://guides.rubyonrails.org/configuring.html#database-pooling
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
```

#### Generate new complete CRUD
```shell script
rails generate scaffold Article title:string description:text
```
or

1. Generate Migration File
```shell script
rails generate migration whatever_change_i_want
```
2. Edit the migration template file
```ruby
class WhateverChangeIWant < ActiveRecord::Migration[6.0]
  def change
    ...
  end
end
```
`...` can be:
```
    create_table :table_name do |t|
      t.data_type :column_name
      .
      .
      .
    end
```
or
```
    add_column :table_name, column_name, :data_type
    ...
```
or
```ruby
    ?
```

Note:
- Class name: Capitalized, singular and CamelCase
- File name: Singular, snake_case and lowercase
- Table name: Plural, snake_case and lowercase


#### Create the database
```shell script
rake db:create # also check: db:rollback & db:
```
```shell script
rails db:migrate
```
