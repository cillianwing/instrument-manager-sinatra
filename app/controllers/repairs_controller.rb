require 'sinatra/base'
require 'rack-flash'

class RepairsController < ApplicationController
  use Rack::Flash

  get '/repairs' do
    if logged_in?
      @repairs = Repair.all
      @user = User.find_by_id(current_user.id)
      erb :'/repairs/index'
    else
      '/login'
    end
  end

  get '/repairs/new' do
    if logged_in?
      @statuses = ["Not Started", "In Progress", "Complete"]
      @user = User.find_by_id(session[:user_id])
      @instruments = @user.instruments
      @items = []
      @instruments.collect do |instrument|
        if instrument.status != "In Repair"
          @items << {name: "#{instrument.make} - #{instrument.model} (#{instrument.type_of})", instrument_id: instrument.id}
        end
      end
      erb :'/repairs/new'
    else
      redirect '/login'
    end
  end

  post '/repairs' do
    if logged_in?
      #binding.pry
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
