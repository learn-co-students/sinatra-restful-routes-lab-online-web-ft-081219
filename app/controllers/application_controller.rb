require "./config/environment"
require "./app/models/recipe"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/' do
    redirect '/recipes'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    Recipe.new(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
    ).tap do |recipe|
      recipe.save
      redirect "/recipes/#{recipe.id}"
    end
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id].to_i)
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.find(params[:id].to_i).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )

      redirect "/recipes/"+recipe.id.to_s

    end
  end

  delete '/recipes/:id' do
    recipe = Recipe.find(params[:id].to_i)
    recipe.destroy
    
    redirect to '/recipes'
  end
end
