require 'sinatra/base'
require 'rack-flash'

class InstrumentsController < ApplicationController
  use Rack::Flash

  get '/instruments' do
    if logged_in?
      @user = User.find_by_id(session[:user_id])
      @instruments = @user.instruments
      erb :'/instruments/index'
    else
      redirect '/login'
    end
  end

  get '/instruments/new' do
    @statuses = ["Usable", "Needs Repair", "In Repair"]
    if logged_in?
      erb :'/instruments/new'
    else
      redirect '/login'
    end
  end

  post '/instruments' do
    if logged_in?
      @instrument = current_user.instruments.create(params)
      if @instrument.save
        redirect "/instruments/#{@instrument.id}"
      else
        redirect '/instruments/new'
      end
    else
      redirect '/login'
    end
  end

  get '/instruments/:id' do
    if logged_in?
      @instrument = current_user.instruments.find_by(params[:id])
      erb :'/instruments/show'
    else
      redirect '/login'
    end
  end

  get '/instruments/:id/edit' do
    if logged_in?
      @statuses = ["Usable", "Needs Repair", "In Repair"]
      @instrument = current_user.instruments.find_by(params[:id])
      erb :'/instruments/edit'
    else
      redirect '/login'
    end
  end

  patch '/instruments/:id' do
    if logged_in?
      @instrument = current_user.instruments.find_by(params[:id])
      if @instrument && @instrument.user_id == current_user.id
        if @instrument.update(status: params[:status], status_comments: params[:status_comments])
          redirect "/instruments/#{@instrument.id}"
        else
          redirect "/instruments/#{@instrument.id}/edit"
        end
      else
        redirect '/instruments'
      end
    else
      redirect '/login'
    end
  end

  get '/instruments/:id/delete' do
    if logged_in?
      @instrument = current_user.instruments.find_by(params[:id])
      erb :'/instruments/delete'
    else
      redirect '/login'
    end
  end

  delete '/instruments/:id' do
    if logged_in?
      @instrument = current_user.instruments.find_by(params[:id])
      if @instrument && @instrument.user_id == current_user.id
        @instrument.delete
      end
      redirect '/instruments'
    else
      redirect '/login'
    end
  end

end
