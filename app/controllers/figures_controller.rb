class FiguresController < ApplicationController
  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/new'
  end

  def update_landmark
    @landmark_name = params[:landmark][:name]

    if @landmark_name && !@figure.landmarks.include?(Landmark.find_by(name: @landmark_name))
        @figure.landmarks << Landmark.find_or_create_by(name: @landmark_name)
    end
    @figure.save
  end

  def update_title
    @title_name = params[:title][:name]
    if @title_name
      @figure.titles << Title.find_or_create_by(name: @title_name)
    end
    @figure.save
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    update_landmark
    update_title

    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    update_landmark
    update_title

    redirect to "/figures/#{@figure.id}"
  end

end
