require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'sinatra/twitter-bootstrap'
require 'better_errors'
require 'sequel'

configure do
  DB = Sequel.sqlite('database.sqlite')
  register Sinatra::Twitter::Bootstrap::Assets
end

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

class Review < Sequel::Model; end

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
  if params[:stop]
    { :rating => -1, :comments => "STOP TALKING! #{params[:comments] || ''}", :created_at => Time.now }
  else
    { :rating => params[:rating], :comments => params[:comments], :created_at => Time.now }
  end
end

