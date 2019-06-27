class RepairsController < ApplicationController

  get '/repairs' do
    if logged_in?
      @repairs = current_user.repairs
      @repairs.each do |repair|
        if repair.item_type.nil?
          repair.clear
        end
      end
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
      if params[:item_class] == "Instrument"
        @item = current_user.instruments.find_by_id(params[:item_id])
      elsif params[:item_class] == "Accessory"
        @item = current_user.accessories.find_by_id(params[:item_id])
      end
      if @item.class.to_s == "Instrument"
        @repair = current_user.repairs.create(instrument_id: params[:item_id])
      elsif @item.class.to_s == "Accessory"
        @repair = current_user.repairs.create(accessory_id: params[:item_id])
      end
      redirect "/repairs/#{@repair[:id]}/new"
    else
      redirect '/login'
    end
  end

  get '/repairs/:id/new' do
    if logged_in?
      @statuses = ["Not Started", "In Progress", "Complete"]
      @repair = current_user.repairs.find_by_id(params[:id])
      if !@repair[:instrument_id].nil?
        @item = current_user.instruments.find_by_id(@repair[:instrument_id])
      elsif !@repair[:accessory_id].nil?
        @item = current_user.accessories.find_by_id(@repair[:accessory_id])
      end
      erb :'/repairs/new'
    else
      redirect '/login'
    end
  end

  post '/repairs' do
    if logged_in?
      current_user.repairs.each do |repair|
        if repair.instrument_id == params[:item_id].to_i
          @repair = repair
          @item = current_user.instruments.find_by_id(params[:item_id])
        elsif repair.accessory_id == params[:item_id].to_i
          @repair = repair
          @item = current_user.accessories.find_by_id(params[:item_id])
        end
      end
      @repair.update(work: params[:work], item_name: params[:item_name], cost: params[:cost], status: params[:status], duration: params[:duration], start_date: params[:start_date], item_type: params[:item_type])
      @item = current_user.instruments.find_by_id(params[:item_id]) || @item = current_user.accessories.find_by_id(params[:item_id])
      @item.status = "In Repair"
      @item.status_comments = "In Repair: #{@repair.work}"
      if @item.class.to_s == "Instrument"
        current_user.instruments.each do |instrument|
          if instrument.id == @item.id
            instrument.status = "In Repair"
            instrument.status_comments = "In Repair: #{@repair.work}"
            instrument.save
          end
        end
      elsif @item.class.to_s == "Accessory"
        current_user.accessories.each do |accessory|
          if accessory.id == @item.id
            accessory.status = "In Repair"
            accessory.status_comments = "In Repair: #{@repair.work}"
            accessory.save
          end
        end
      end
      if @repair.save
        erb :"/repairs/show"
      else
        redirect "/repairs/#{@repair.id}/new"
      end
    else
      redirect '/login'
    end
  end

  get '/repairs/:id/edit' do
    if logged_in?
      @statuses = ["Not Started", "In Progress"]
      @repair = current_user.repairs.find_by_id(params[:id])
      erb :"/repairs/edit"
    else
      redirect '/login'
    end
  end

  patch '/repairs/:id' do
    if logged_in?
      @repair = current_user.repairs.find_by_id(params[:id])
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
    if logged_in?
      @repair = current_user.repairs.find_by_id(params[:id])
      erb :"/repairs/complete"
    else
      redirect '/login'
    end
  end

  delete '/repairs/:id' do
    if logged_in?
      @repair = current_user.repairs.find_by_id(params[:id])
      @item = current_user.instruments.find_by_id(@repair[:instrument_id]) || @item = current_user.accessories.find_by_id(@repair[:accessory_id])
      if @item.class.to_s == "Instrument"
        current_user.instruments.each do |instrument|
          if instrument.id == @item.id
            instrument.status = "Useable"
            instrument.status_comments = "Repair complete - ready to jam!"
            instrument.save
          end
        end
      elsif @item.class.to_s == "Accessory"
        current_user.accessories.each do |accessory|
          if accessory.id == @item.id
            accessory.status = "Useable"
            accessory.status_comments = "Repair complete - ready to jam!"
            accessory.save
          end
        end
      end
      @repair.destroy
      redirect '/repairs'
    else
      redirect '/login'
    end
  end

end
