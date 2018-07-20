class LandmarksController < ApplicationController
	get('/landmarks/new'){
		erb :"landmarks/new"
	}

	post '/landmarks' do
		Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
		redirect to('/landmarks')
	end

	get '/landmarks' do
		@landmarks = Landmark.all
		erb :"landmarks/index"
	end

	get '/landmarks/:id' do 
		@landmark = Landmark.find(params[:id])
		erb :"landmarks/show"
	end

	get '/landmarks/:id/edit' do
		@landmark = Landmark.find(params[:id])
		erb :"/landmarks/edit"
	end

	patch '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		# binding.pry
		@landmark.update(params[:landmark])
		redirect to("/landmarks/#{@landmark.id}")
	end
end
