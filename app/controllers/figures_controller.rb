require 'pry'

class FiguresController < ApplicationController
	get '/figures' do
		# binding.pry
		@figures = Figure.all
		erb :"figures/index"
	end

	get '/figures/new' do
		@titles = Title.all
		@landmarks = Landmark.all
		
		erb :"figures/new"
	end

	post '/figures' do
		figure = Figure.new(name: params[:figure][:name])


		if params[:figure][:title_ids] != nil
				params[:figure][:title_ids].each do |id|
					figure.titles << Title.find(id)
				end
			end


		if params[:figure][:landmark_ids] != nil
		 	params[:figure][:landmark_ids].each do |id|
				figure.landmarks << Landmark.find(id)
			end
		end
		
		figure.titles << Title.create(params[:title]) if params[:title][:name] != "" && params[:title] != nil 
		if params[:landmark][:name] != "" && params[:landmark] != nil
			new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
			figure.landmarks << new_landmark
		end
		
		figure.save

		redirect to '/figures'
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		# binding.pry
		@landmarks = @figure.landmarks
		@titles = @figure.titles
		erb :"figures/show"
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		@titles = Title.all
		@landmarks = Landmark.all
		# binding.pry
		erb :"figures/edit"
	end

	patch '/figures/:id' do 
      @figure = Figure.find(params[:id])
      @figure.update(params[:figure])
      
      if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end
      
      @figure.save
      redirect to "/figures/#{@figure.id}"
    end

end
