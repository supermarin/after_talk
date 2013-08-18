require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'better_errors'
require 'sequel'


DB = Sequel.sqlite('database.sqlite')

register Sinatra::Twitter::Bootstrap::Assets

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end


get '/' do
  haml :survey
end

post '/review' do
  reviews = DB[:reviews]
  reviews.insert(:rating => params[:rating], :comments => params[:comments])
  haml :thanks
end

get '/reviews' do
  @reviews = DB[:reviews].all
  haml :reviews
end

