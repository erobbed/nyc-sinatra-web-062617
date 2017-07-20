class LandmarksController < ApplicationController
  get '/landmarks/new' do
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  post '/landmarks' do
    landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    landmark.update(
    year_completed: params[:landmark][:year_completed],
    figure: Figure.find(params[:landmark][:figure])
    )
    redirect to "/landmarks/#{landmark.id}"
  end

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/:id' do
    @landmark= Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params[:landmark])
    redirect to "/landmarks/#{@landmark.id}"
  end

end
