class AccessoriesController < ApplicationController

  get '/accessories' do
    if logged_in?
      @accessories = current_user.accessories
      erb :'/accessories/index'
    else
      redirect '/login'
    end
  end

  get '/accessories/new' do
    @statuses = ["Useable", "Needs Repair", "In Repair"]
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
      @statuses = ["Useable", "Needs Repair", "In Repair"]
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
        @accessory.destroy
      end
      redirect '/accessories'
    else
      redirect '/login'
    end
  end
end
