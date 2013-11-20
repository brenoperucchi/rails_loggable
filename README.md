Rails Loggable
==============

Create Logs of changes of ActiveRecord in any model you need.

* Gem isn't tested and I accept help

Log:

```HTML
USER                           DESCRIPTION                                        DATE
admin ID: 1 - Model Debit Create State:                               2013-11-20 20:09:41 UTC
admin ID: 1 - Model Debit changed: State: canceled TO State: pending  2013-11-20 20:09:41 UTC
user  ID: 1 - Model Credit changed: State: canceled TO State: paid    2013-11-20 20:09:41 UTC
```

## Compatibility
* Only Rails 4

* I'll test with Rails 3 another time

This is not similar project as Paper Trail and Auditable. Only provide the way to create a register in Model LOG of the changes the attributes


## Installation 

1. Add `RailsLoggable` to your `Gemfile`.

    `gem 'rails_loggable' git: 'https://github.com/bperucchi/rails_loggable.git'`

2. You need to create Model LOG

    ```ruby 
    class CreateLogs < ActiveRecord::Migration
      def change
        create_table :logs do |t|
          t.string :description
          t.references :user
          t.references :loggable, :polymorphic => true
          t.timestamps
        end
      end
    end
    ```

3. Run the migration.

    `bundle exec rake db:migrate`

4. You need to put in you locale this:
    ```YAML
    en:
      rails_loggable:
        loggable_changed: "ID: %{id} - %{model} changed: %{before} TO %{after}"

* recommend to create in your Rails APP/config/locale/en.railsloggable.yml

## Basic Usage

```ruby
class Debit < ActiveRecord::Base
  rails_loggable
end
```

## Options
```ruby
class Debit < ActiveRecord::Base
  rails_loggable :ignore => [:updated_at, :created_at], :log_attributes => :id
end
```

`ignore =>` will ignore the attributes to the description log 

`log_attributes =>` will add to the attribute to the description log

This project rocks and uses MIT-LICENSE.