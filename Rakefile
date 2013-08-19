require 'sequel'

namespace :db do
  task :create do
    DB = Sequel.sqlite('database.sqlite')
    DB.create_table :reviews do
      primary_key :id
      String :comments
      Int :rating
      Time :created_at
    end
  end
end
