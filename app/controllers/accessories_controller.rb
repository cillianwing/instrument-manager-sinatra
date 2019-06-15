class AccessoriesController < ApplicationController

  # GET: /accessories
  get "/accessories" do
    erb :"/accessories/index.html"
  end

  # GET: /accessories/new
  get "/accessories/new" do
    erb :"/accessories/new.html"
  end

  # POST: /accessories
  post "/accessories" do
    redirect "/accessories"
  end

  # GET: /accessories/5
  get "/accessories/:id" do
    erb :"/accessories/show.html"
  end

  # GET: /accessories/5/edit
  get "/accessories/:id/edit" do
    erb :"/accessories/edit.html"
  end

  # PATCH: /accessories/5
  patch "/accessories/:id" do
    redirect "/accessories/:id"
  end

  # DELETE: /accessories/5/delete
  delete "/accessories/:id/delete" do
    redirect "/accessories"
  end
end
