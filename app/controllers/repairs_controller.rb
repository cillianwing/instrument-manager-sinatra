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
      # Need to add instrument/accessory object to current_user.repairs
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

  post '/repairs/:id' do
    if logged_in?
      @repair = current_user.repairs.build(params)
      @item = current_user.instruments.find_by_id(params[:id])
      @item.status = "In Repair"
      if @repair.save
        redirect "/repairs/#{@repair.id}"
      else
        redirect '/repairs/new'
      end
    else
      redirect '/login'
    end
  end

  get '/repairs/:repair_id' do
    if logged_in?
      @repair = Repair.find_by_id(params[:repair_id])
      erb :'/repairs/show'
    else
      redirect '/login'
    end
  end

  get '/repairs/:repair_id/edit' do
    if logged_in?
      @statuses = ["Not Started", "In Progress", "Complete"]
      @repair = Repair.find_by_id(params[:repair_id])
      erb :"/repairs/edit"
    else
      redirect '/login'
    end
  end

  patch '/repairs/:repair_id' do
    if logged_in?
      @repair = Repair.find_by_id(params[:repair_id])
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

  get '/repairs/:repair_id/complete' do
    if logged_in?
      @repair = current_user.repairs.find_by_id(params[:repair_id])

    else
      redirect '/login'
    end
  end

  delete '/repairs/:repair_id' do

  end

end
