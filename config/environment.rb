ENV['SINATRA_ENV'] ||= "development"

require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/development.sqlite"
)

require './app/controllers/application_controller'
require_all 'app'
