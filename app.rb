require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'better_errors'
require 'sequel'
require 'date'

DB = Sequel.sqlite('database.sqlite')
class Review < Sequel::Model; end

register Sinatra::Twitter::Bootstrap::Assets
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end


get '/' do
  haml :survey
end

post '/review' do
  Review.create(review_params)
  haml :thanks
end

get '/reviews' do
  @reviews = Review.all
  haml :reviews
end


private

def review_params
  { :rating => params[:rating], :comments => params[:comments], :created_at => DateTime.now.to_date }
end

