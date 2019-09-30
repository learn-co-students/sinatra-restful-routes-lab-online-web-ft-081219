class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here! 
  get '/recipes' do 
    @recipes = Recipe.all 
    erb :index
  end 
  
  get '/recipes/new' do 
    erb :new
  end 
  
  post '/recipes' do
    p params
    if params["name"] !="" && params["ingredients"] !="" && params["cook_time"] !=""
      @recipe = Recipe.create(name: params["name"], ingredients: params["ingredients"], cook_time: params["cook_time"])
       redirect "/recipes/#{@recipe.id}"
     else 
       redirect '/recipes/new'
    end
   
  end 
  
  get '/recipes/:id' do 
    @recipe = Recipe.find(params['id'].to_i)
    erb :show
  end 
  
  get '/recipes/:id/edit' do
    p params 
    p "====================="
    p "====================="
    @recipe = Recipe.find(params['id']) 
    p @recipe
    erb :edit
  end 
  
  patch '/recipes/:id' do 
    p params
     @recipe = Recipe.find(params['id'])
      @recipe.update(name: params['name'], ingredients: params['ingredients'], cook_time: params['cook_time'])
    redirect "/recipes/#{@recipe.id}"
  end 
  
  delete '/recipes/:id' do 
    @recipe = Recipe.find(params["id"]) 
    @recipe.delete 
    redirect '/recipes'
  end

end
