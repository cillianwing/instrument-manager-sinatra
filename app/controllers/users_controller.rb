class UsersController < ApplicationController

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
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      @user.save
      redirect "/users/#{@user.id}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :"/users/login"
    else
      @user = User.find_by_id(session[:user_id])
      redirect "/users/#{@user.id}"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      #flash message saying username not found or incorrect password
      #flash[:error] = "Incorrect username or password."
      redirect '/login'
    end
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
    else
      redirect '/login'
    end
  end

end
