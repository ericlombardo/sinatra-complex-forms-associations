class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do # create pet, assign owner, create owner if one
    if params[:owner][:name].empty?
     @pet = Pet.create(params[:pet])
    else
      owner = Owner.create(params[:owner])
      @pet = Pet.create(name: params[:pet][:name], owner_id: owner.id)
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    if params[:owner][:name].empty?
      @pet.update(params[:pet])
    else
      @pet.update(params[:pet]) 
      @pet.owner_id = Owner.create(params[:owner]).id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end