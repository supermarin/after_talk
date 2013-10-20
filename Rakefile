require 'sequel'

desc 'Set up development environment for the first time'
task :bootstrap do
  sh 'bundle install'
  Rake::Task['db:create'].invoke
end

desc 'Launch the app, let people rate you'
task :server do
  hostname = `hostname`.chomp
  puts "#" * 50
  puts "People can rate you by visiting #{hostname}.local:4567"
  puts "#" * 50
  sh 'ruby app.rb -o 0.0.0.0'
end

namespace :db do
  task :create do
    DB = Sequel.sqlite('database.sqlite')
    DB.create_table :reviews do
      primary_key :id
      String :comments
      Int :rating
      Time :created_at
    end rescue puts "Database was already created!"
  end
end

