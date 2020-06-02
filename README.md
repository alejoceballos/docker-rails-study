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

#### Create the database

```shell script
rake db:create # also check: db:rollback & db:...
```

#### Generate new complete CRUD

The command below generates a lot of files, I'm not sure the real need for all of them. Prefer the file by file steps 
below.
```shell script
rails generate scaffold Article title:string description:text
rails db:migrate
```
or (preferable)

##### 1. Generate migration file
```shell script
rails generate migration <model_name>
```
It creates a file named `YYYYMMDDHHmmSS_create_model_name.rb` with a class `CreateModelName` in it.

##### 2. Edit the migration template file
```ruby
class CreateModelName < ActiveRecord::Migration[6.0]
  def change
    # create, update or delete table structure here
  end
end
```
**Note:** The name of the file must match the name of the class. So, for example, if the class name is changed to 
`CreateMyModelName` the file name must be changed to `YYYYMMDDHHmmSS_create_my_model_name.rb`.

Inside `change` method could be:
```ruby
    create_table :model_names do |t|
      t.data_type :column_name
      .
      .
      .
    end
```
**Note:** to follow the example below, note that the name of the table must be the model's one, but pluralized. Nothing 
to do with the name of the migration script though.

or
```ruby
    add_column :model_names, column_name, :data_type
    ...
```
or
```ruby
    ?
```

**Model naming summary:**
- Class name: Capitalized, singular and CamelCase
- File name: Singular, snake_case and lowercase
- Table name: Plural, snake_case and lowercase

##### 3. Create database table
```shell script
rails db:migrate
```
In case the database is still empty, this command creates three tables:
1. **ar_internal_metadata:** holds the environment type, in this case `development`;
2. **schema_migrations:** holds all migration file's prefixes that has already been executed. This prevents running the 
same migration twice;
3. **user_skill_levels:** the table representing model's data;

Running `rails db:migrate` will create (or update) `db\schema.rb` file. It holds the current database schema. As its 
documentation states:
> This file is the source Rails uses to define your schema when running `rails db:schema:load`. When creating a new 
> database, `rails db:schema:load` tends to be faster and is potentially less error prone than running all of your 
> migrations from scratch.

##### 4. Create the Model

Create a file named `user_skill_level` under `app/models` folder with content:
```ruby
class UserSkillLevel < ApplicationRecord
end
```
**Notes:** 
1. Model's name must be the singular of the table's name.
2. `ApplicationRecord` extends from `ActiveRecord`. Rails framework provides all setters and getters for every 
table column referenced as an attribute by naming convention.
