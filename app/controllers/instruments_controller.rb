class InstrumentsController < ApplicationController

  get '/instruments' do
    if logged_in?
      @instruments = current_user.instruments
      erb :'/instruments/index'
    else
      redirect '/login'
    end
  end

  get '/instruments/new' do
    @statuses = ["Useable", "Needs Repair", "In Repair"]
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
        redirect to "/instruments/#{@instrument.id}"
      else
        redirect '/instruments/new'
      end
    else
      redirect '/login'
    end
  end

  get '/instruments/:id' do
    if logged_in?
      @instrument = Instrument.find_by_id(params[:id])
      erb :'/instruments/show'
    else
      redirect '/login'
    end
  end

  get '/instruments/:id/edit' do
    if logged_in?
      @statuses = ["Usable", "Needs Repair", "In Repair"]
      @instrument = Instrument.find_by_id(params[:id])
      erb :'/instruments/edit'
    else
      redirect '/login'
    end
  end

  patch '/instruments/:id' do
    if logged_in?
      @instrument = Instrument.find_by_id(params[:id])
      if @instrument && @instrument.user_id == current_user.id
        if @instrument.update(status: params[:status], status_comments: params[:status_comments])
          erb :'/instruments/show'
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
      @instrument = Instrument.find_by_id(params[:id])
      erb :'/instruments/delete'
    else
      redirect '/login'
    end
  end

  delete '/instruments/:id' do
    if logged_in?
      @instrument = Instrument.find_by_id(params[:id])
      if @instrument && @instrument.user_id == current_user.id
        @instrument.destroy
      end
      redirect '/instruments'
    else
      redirect '/login'
    end
  end

end
