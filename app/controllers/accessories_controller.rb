require 'sinatra/base'
require 'rack-flash'

class AccessoriesController < ApplicationController
  use Rack::Flash

  get '/accessories' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @accessories = @user.accessories
      erb :'/accessories/index'
    else
      redirect '/login'
    end
  end

  get '/accessories/new' do
    @statuses = ["Usable", "Needs Repair", "In Repair", "On Loan"]
    if logged_in?
      erb :'/accessories/new'
    else
      redirect '/login'
    end
  end

  post '/accessories' do
    if logged_in?
      @accessory = current_user.accessories.create(params)
      if @accessory.save
        redirect "/accessories/#{@accessory.id}"
      else
        redirect '/accessories/new'
      end
    else
      redirect '/login'
    end
  end

  get '/accessories/:id' do
    if logged_in?
      @accessory = Accessory.find_by_id(params[:id])
      erb :'/accessories/show'
    else
      redirect '/login'
    end
  end

  get '/accessories/:id/edit' do
    if logged_in?
      @statuses = ["Usable", "Needs Repair", "In Repair"]
      @accessory = Accessory.find_by_id(params[:id])
      erb :'/accessories/edit'
    else
      redirect '/login'
    end
  end

  patch '/accessories/:id' do
    if logged_in?
      @accessory = Accessory.find_by_id(params[:id])
      if @accessory && @accessory.user_id == current_user.id
        if @accessory.update(status: params[:status], status_comments: params[:status_comments])
          redirect "/accessories/#{@accessory.id}"
        else
          redirect "/accessories/#{@accessory.id}/edit"
        end
      else
        redirect '/accessories'
      end
    else
      redirect '/login'
    end
  end

  get '/accessories/:id/delete' do
    if logged_in?
      @accessory = Accessory.find_by_id(params[:id])
      erb :'/accessories/delete'
    else
      redirect '/login'
    end
  end

  delete '/accessories/:id' do
    if logged_in?
      @accessory = Accessory.find_by_id(params[:id])
      if @accessory && @accessory.user_id == current_user.id
        @accessory.delete
      end
      redirect '/accessories'
    else
      redirect '/login'
    end
  end
end
