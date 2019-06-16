require 'sinatra/base'
require 'rack-flash'

class RepairsController < ApplicationController
  use Rack::Flash

end
