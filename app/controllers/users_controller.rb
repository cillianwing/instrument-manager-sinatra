require 'sinatra/base'
require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :"/users/new"
    else
      redirect "/login"
    end
  end

  post '/signup' do
    if User.find_by(username: params[:username])
      #flash message saying username already exists?
      redirect '/login'
    else
      #flash message saying signup successful
      @user = User.create(username: params[:username], email: params[:email], password_digest: params[:password])
      session[:user_id] = @user.id
      @user.save
      redirect "/users/#{@user.id}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      erb :"/users/show"
    end
  end

  post '/login' do

  end

  get '/users/:id' do
    if !logged_in?
      redirect '/login'
    else
      @user = User.find_by_id(session[:user_id])
      @instruments = @user.instruments
      @accessories = @user.accessories
      erb :"users/index"
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/'
    end
  end

end

=begin
  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  # GET: /users/new
  get "/users/new" do
    erb :"/users/new.html"
  end

  # POST: /users
  post "/users" do
    redirect "/users"
  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
=end
