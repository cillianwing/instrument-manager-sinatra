require 'sinatra/base'
require 'rack-flash'

class RepairsController < ApplicationController
  use Rack::Flash

  get '/repairs' do
    if logged_in?
      @repairs = Repair.all
      erb :'/repairs/index'
    else
      '/login'
    end
  end

  get '/repairs/news' do

  end

  post '/repairs' do

  end

  get '/repairs/:id' do

  end

  get '/repairs/:id/edit' do

  end

  patch '/repairs/:id' do

  end

  get '/repairs/:id/complete' do

  end

  delete '/repairs/:id' do
    
  end

end
