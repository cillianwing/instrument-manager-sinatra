require 'sinatra/base'
require 'rack-flash'

class InstrumentsController < ApplicationController
  use Rack::Flash

  get 'instruments' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @instruments = @user.instruments
      erb :'/instruments/index'
    else
      redirect '/login'
    end
  end

  get '/new_instrument' do
    @statuses = ["Usable", "Needs Repair", "In Repair"]
    if logged_in?
      erb :'/instruments/new'
    else
      redirect '/login'
    end
  end

  post '/instruments' do
    @instrument = Instrument.create(params)
    @instrument.user_id = session[:user_id]
    redirect "/instruments/#{@instrument.id}"
  end

  get '/instruments/:id' do
    if logged_in?
      @instrument = Instrument.find_by(params[:id])
      erb :'/instruments/show'
    else
      redirect '/login'
    end
  end

end

=begin
# GET: /instruments
get "/instruments" do
  erb :"/instruments/index.html"
end

# GET: /instruments/new
get "/instruments/new" do
  erb :"/instruments/new.html"
end

# POST: /instruments
post "/instruments" do
  redirect "/instruments"
end

# GET: /instruments/5
get "/instruments/:id" do
  erb :"/instruments/show.html"
end

# GET: /instruments/5/edit
get "/instruments/:id/edit" do
  erb :"/instruments/edit.html"
end

# PATCH: /instruments/5
patch "/instruments/:id" do
  redirect "/instruments/:id"
end

# DELETE: /instruments/5/delete
delete "/instruments/:id/delete" do
  redirect "/instruments"
end
=end
