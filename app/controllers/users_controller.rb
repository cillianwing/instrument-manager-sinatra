class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :"/users/new"
    else
      erb :"/users/index"
    end
  end

  post '/signup' do
    
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      erb :"/users/index"
    end
  end

  post '/login' do

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
