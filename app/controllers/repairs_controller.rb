require 'sinatra/base'
require 'rack-flash'

class RepairsController < ApplicationController
  use Rack::Flash

  get '/repairs' do
    if logged_in?
      @repairs = current_user.repairs
      erb :'/repairs/index'
    else
      '/login'
    end
  end

  get '/repairs/select' do
    if logged_in?
      @items = current_user.instruments + current_user.accessories
      erb :"/repairs/select"
    else
      redirect "/login"
    end
  end

  post '/repairs/select' do
    if logged_in?
      @item = current_user.instruments.find_by_id(params[:item_id])
      redirect "/repairs/#{@item[:id]}/new"
    else
      redirect '/login'
    end
  end

  get '/repairs/:id/new' do
    if logged_in?
      @statuses = ["Not Started", "In Progress", "Complete"]
      @item = current_user.instruments.find_by_id(params[:id])
      erb :'/repairs/new'
    else
      redirect '/login'
    end
  end

  post '/repairs' do
    if logged_in?
      @repair = current_user.repairs.build(params)
      if @repair.save
        redirect "/repairs/#{@repair.id}"
      else
        redirect '/repairs/new'
      end
    else
      redirect '/login'
    end
  end

  get '/repairs/:id' do
    if logged_in?
      @repair = Repair.find_by_id(params[:id])
      erb :'/repairs/show'
    else
      redirect '/login'
    end
  end

  get '/repairs/:id/edit' do
    if logged_in?
      @statuses = ["Not Started", "In Progress", "Complete"]
      @repair = Repair.find_by_id(params[:id])
      erb :"/repairs/edit"
    else
      redirect '/login'
    end
  end

  patch '/repairs/:id' do
    if logged_in?
      @repair = Repair.find_by_id(params[:id])
      if @repair && @repair.user_id == session[:user_id]
        if @repair.update(status: params[:status])
          erb :'/repairs/show'
        else
          redirect "/repairs/#{@repair.id}/edit"
        end
      end
    else
      redirect '/login'
    end
  end

  get '/repairs/:id/complete' do

  end

  delete '/repairs/:id' do

  end

end
