# API

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

Possible solution for remote debugging:
- https://europepmc.github.io/techblog/rails/2017/11/03/rubymine-remote-debug-rails-in-docker.html
```
rdebug-ide --host 0.0.0.0 --port 1234 --dispatcher-port 26162 -- bin/rails s
```

#### New Project

```shell script
rails new . --force --no-deps --database=postgresql
```

#### Update DB config

```yaml
# config\database.yml

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

#### Make an API only project

##### 1. 
```ruby
# config\application.rb
.
.
.
module NameOfMyProject
  class Application < Rails::Application
    .
    .
    .
    config.api_only = true
  end
end
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

Complete example:
```ruby
class CreateUserSkillLevel < ActiveRecord::Migration[6.0]
  def change
    create_table :user_skill_levels do |t|
      t.string :user_name
      t.string :skill
      t.integer :level
    end
  end
end
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

##### 5. Insert some data using Rails console
```shell script
rails console
```
```
Running via Spring preloader in process 284
Loading development environment (Rails 6.0.3.1)
irb(main):001:0>
```
```
irb(main):001:0> UserSkillLevel.create user_name: "Alejo Ceballos", skill: "Ruby", level: 2
```
or
```
irb(main):001:0> skill = UserSkillLevel.new
irb(main):002:0> skill.user_name = "Alejo Ceballos"
irb(main):003:0> skill.skill = "Ruby on Rails"
irb(main):004:0> skill.level = 1
irb(main):005:0> skill.save
```
```
(0.2ms)  BEGIN
UserSkillLevel Create (0.6ms)  INSERT INTO "user_skill_levels" ("user_name", "skill", "level") VALUES ($1, $2, $3) RETURNING "id"  [["user_name", "Alejo Ceballos"], ["skill", "Ruby on Rails"], ["level", 1]]
(11.2ms)  COMMIT
=> true
```

##### 6. Read, Update and Delete using Rails console
TBD

##### 7. Validations    
```ruby
# app\models\user_skill_level.rb

class UserSkillLevel < ApplicationRecord
  validates :skill, presence: true
  validates :user_name, presence: true
  validates :level, presence: true, :numericality => true, :inclusion => { :in => 0..5 }
end
```

##### 8. Routing
```ruby
# config\routes.rb

Rails.application.routes.draw do
  resources :user_skill_level
end
```
